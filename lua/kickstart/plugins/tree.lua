return {
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
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
