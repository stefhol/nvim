return {
  {
    "CoreyKaylor/diffbandit.nvim",
    --branch = 'fix/wrap-line-numbers',
    branch = 'main',
    config = function()
      require("diffbandit").setup({
        diff = {
          ignore_whitespace = false,
        },
        navigation = {
          initial_focus = "right",
          align_on_jump = true,
          align_strategy = "change_top",
          document_keys = {
            top = "[d",
            bottom = "]d",
          },
          snap_key = "]s",
        },
        git = {
          default_mode = "all",
          include_untracked = true,
          find_renames = true,
          file_keys = {
            next = "]f",
            prev = "[f",
          },
          panel = {
            width = 42,
            commit_height = 10,
            preview_on_cursor = true,
            keys = {
              toggle_stage = "<Space>",
              focus_diff = "<CR>",
              focus_panel = "C",
              focus_commit = "cc",
              file_actions = "a",
              toggle_amend = "<Space>",
              refresh = "R",
              close = "q",
            },
          },
        },
        merge = {
          result_initial_content = "base",
          auto_apply_non_conflicting = false,
          resolve_on_write = true,
          line_endings = {
            warn = true,
          },
          keys = {
            next_conflict = "]c",
            prev_conflict = "[c",
            accept_local = ">>",
            accept_remote = "<<",
            accept_both = "gb",
            apply_non_conflicting = "gA",
            focus_panel = "C",
            snap = "]s",
            toggle_panel = "gzp",
            toggle_local = "gzh",
            toggle_remote = "gzl",
            show_all = "gza",
            close = "q",
          },
        },
        folder = {
          gutter_width = 7,
          columns = {
            size = true,
            modified = true,
          },
          compare = {
            mode = "digest",
            backend = "auto",
            batch_size = 64,
            max_concurrency = 2,
            debounce_ms = 50,
          },
          filters = {
            include = {},
            exclude = {},
          },
          keys = {
            open = "<CR>",
            alternate_open = "o",
            toggle_expand = "<Space>",
            alternate_toggle_expand = "za",
            expand_all = "zR",
            collapse_all = "zM",
            next_diff = "]c",
            prev_diff = "[c",
            refresh = "R",
            filter = "s",
            close = "q",
          },
        },
        ui = {
          -- Connector core width. Defaults fix the gutter at 9 columns
          -- (min == max). Raise connector_max_width to allow once-per-document
          -- pressure expansion; set both equal for a different fixed width.
          connector_width = 9,
          connector_max_width = 9,
          scroll_debounce_ms = 16,
          -- "auto" | "kitty" | "cells" (see Image connectors below).
          connector_renderer = "auto",
          kitty = {
            transmission = "auto", -- "auto" | "file" | "direct"
            compress = true,
            probe_timeout_ms = 300,
            passthrough = "auto",                                     -- "auto" | "tmux" | "none"
            tmux_terminals = nil,                                     -- terminals trusted behind tmux (default Ghostty, Kitty)
            tmux_passthrough_all = true,                              -- see tmux below
            max_image_px = 4000000,
            cell_px = nil,                                            -- { w, h } override; measured via the tty, else a 20x40 (HiDPI) estimate
            divider_width = 1.45,                                     -- curve width in line heights (IntelliJ's 24px divider)
            insertion_line = { thickness = 1 / 18, offset = 1 / 18 }, -- matches the terminal underline
            image_colorspace = "auto",                                -- "srgb" | "display-p3" (auto: P3 for Ghostty on macOS)
          },
          split_blend = 0.3,
          overview = {
            enabled = true,
            width = 1,
            cursor = true,
          },
          status = {
            enabled = true,
            icons = "auto",
          },
          theme = {
            auto_refresh = true,
            background = nil,  -- reference bg for blending when Normal has none (e.g. "#1e1e2e")
            transparent = nil, -- nil: detect from Normal; true/false forces see-through panes
            semantic_blend = 0.3,
            change_emphasis_strength = 0.16,
            min_background_delta = 0.08,
            colors = {
              add = nil,
              delete = nil,
              change = nil,
              change_emphasis = nil,
            },
            highlights = {},
          },
        },
        actions = {
          staged_indicator = {
            unstaged = "□",
            staged = "▣",
          },
        },
      })

      -- DiffBandit review of the fugitive status-buffer entry under the cursor.
      -- Each fugitive section means a different git comparison, so pick the
      -- mode per section instead of relying on git.default_mode ("all" =
      -- worktree vs HEAD, which hides the index).
      local section_modes = {
        Staged = "staged",      -- index vs HEAD
        Unstaged = "unstaged",  -- worktree vs index
        Untracked = "unstaged", -- worktree vs nothing
      }

      local function fugitive_section(lnum)
        local lines = vim.api.nvim_buf_get_lines(0, 0, lnum - 1, false)
        for i = #lines, 1, -1 do
          local heading = lines[i]:match("^(%u%l+)%s*%(%d+%+?%)$") or lines[i]:match("^(%u%l+)$")
          if heading then
            return heading
          end
        end
      end

      local function fugitive_work_tree()
        local status = vim.b.fugitive_status
        if type(status) == "table" and type(status.work_tree) == "string" and status.work_tree ~= "" then
          return status.work_tree
        end
        local ok_repo, repo = pcall(vim.fn["fugitive#repo"])
        if ok_repo then
          local ok_tree, tree = pcall(function()
            return repo.tree()
          end)
          if ok_tree and type(tree) == "string" and tree ~= "" then
            return tree
          end
        end
        return vim.fn.getcwd()
      end

      -- Fugitive's own porcelain parser resolves the cursor line to a real
      -- path (renames, deletes, staged/unstaged, untracked). It returns an
      -- fnameescape()d string, so unescape it before diffbandit sees it.
      local function fugitive_target()
        local ok, cfile = pcall(vim.fn["fugitive#PorcelainCfile"])
        local path = ok and type(cfile) == "string" and cfile ~= "" and (cfile:gsub("\\(.)", "%1")) or nil
        if not path or path:sub(1, 1) ~= "/" then
          return nil
        end
        local stat = (vim.uv or vim.loop).fs_stat(path)
        return {
          path = path,
          mode = section_modes[fugitive_section(vim.api.nvim_win_get_cursor(0)[1]) or ""],
          is_dir = path:sub(-1) == "/" or (stat ~= nil and stat.type == "directory"),
        }
      end

      -- A conflicted path has no index stage 0, so git_file() can only render
      -- "Unmerged file: resolve conflicts outside DiffBandit". The three-pane
      -- resolver is a separate entry point (diffbandit.merge), and it is the
      -- only one that can write the result and `git add` it on :w.
      local function is_unmerged(root, path)
        local out = vim.fn.systemlist({ "git", "-C", root, "ls-files", "--unmerged", "--", path })
        return vim.v.shell_error == 0 and #out > 0
      end

      local function diffbandit_under_cursor()
        local diffbandit = require("diffbandit")
        local target = fugitive_target()
        local session, err

        if not target then
          -- Not on a file entry (section heading, commit, blank line).
          session, err = diffbandit.git_panel({ root = fugitive_work_tree() })
        elseif target.is_dir then
          -- "? pitch/": git expands the pathspec to the files inside, so open
          -- with the file panel instead of silently showing just the first.
          session, err = diffbandit.git_panel({ scope = "current", path = target.path, mode = target.mode })
        elseif is_unmerged(fugitive_work_tree(), target.path) then
          -- Fugitive lists a conflicted file under both Unstaged and Staged;
          -- the section mode is meaningless here, so ignore it.
          session, err = diffbandit.merge(target.path)
        else
          session, err = diffbandit.git_file(target.path, { mode = target.mode })
        end

        if not session then
          vim.notify("diffbandit: " .. (err or "nothing to show"), vim.log.levels.WARN)
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitive",
        group = vim.api.nvim_create_augroup("custom_diffbandit_fugitive", { clear = true }),
        callback = function(event)
          vim.keymap.set("n", "<leader>gd", diffbandit_under_cursor, {
            buffer = event.buf,
            desc = "DiffBandit: diff entry under cursor",
          })
        end,
      })
    end,
  }
}
