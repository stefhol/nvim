--
-- This function has been generated from your
--   view.mappings.list
--   view.mappings.custom_only
--   remove_keymaps
--
-- You should add this function to your configuration and set on_attach = on_attach in the nvim-tree setup call.
--
-- Although care was taken to ensure correctness and completeness, your review is required.
--
-- Please check for the following issues in auto generated content:
--   "Mappings removed" is as you expect
--   "Mappings migrated" are correct
--
-- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
--

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings. Feel free to modify or remove as you wish.
  --
  -- BEGIN_DEFAULT_ON_ATTACH
  api.config.mappings.default_on_attach(bufnr)
  -- END_DEFAULT_ON_ATTACH


  -- Mappings removed via:
  --   remove_keymaps
  --   OR
  --   view.mappings.list..action = ""
  --
  -- The dummy set before del is done for safety, in case a default mapping does not exist.
  --
  -- You might tidy things by removing these along with their default mapping.
  vim.keymap.set('n', 'H', '', { buffer = bufnr })
  vim.keymap.del('n', 'H', { buffer = bufnr })
  vim.keymap.set('n', 'J', '', { buffer = bufnr })
  vim.keymap.del('n', 'J', { buffer = bufnr })
  vim.keymap.set('n', 'K', '', { buffer = bufnr })
  vim.keymap.del('n', 'K', { buffer = bufnr })
  vim.keymap.set('n', 'L', '', { buffer = bufnr })
  vim.keymap.del('n', 'L', { buffer = bufnr })
end
return {
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        on_attach = on_attach,
        disable_netrw = false,
        hijack_cursor = true,
        remove_keymaps = { "H", "J", "K", "L" }, -- conflicts with window resize
        view = {
          width = {},
        },
        renderer = {
          full_name = true,
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              folder_arrow = false,
            },
          }
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            window_picker = {
              enable = true,
              picker = function()
                return vim.fn.win_getid(vim.fn.winnr("#"))
              end
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
        }
      }
      -- require("nvim-tree.api").tree.toggle({
      --   path = nil,
      --   current_window = false,
      --   find_file = false,
      --   update_root = true,
      --   focus = false,
      -- })
      vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
                -- open file_browser with the path of the current buffer
              },
            },
          },
        },
      }
      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      require("telescope").load_extension "file_browser"
      vim.api.nvim_set_keymap(
        "n",
        "<space>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true",
        { noremap = true }
      )
    end
  },
}
