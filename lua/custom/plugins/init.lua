-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>hm", function()
        harpoon:list():add()
      end, {
        desc = "[H]arpoon [M]ark",
      })
      vim.keymap.set("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, {
        desc = "[H]arpoon [H]arpoons",
      })

      vim.keymap.set("n", "<leader>hf", function()
        harpoon:list():select(1)
      end, {
        desc = "[H]arpoon 1",
      })
      vim.keymap.set("n", "<leader>hg", function()
        harpoon:list():select(2)
      end, {
        desc = "[H]arpoon 2",
      })
      vim.keymap.set("n", "<leader>hj", function()
        harpoon:list():select(3)
      end, {
        desc = "[H]arpoon 3",
      })
      vim.keymap.set("n", "<leader>hk", function()
        harpoon:list():select(3)
      end, {
        desc = "[H]arpoon 4",
      })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<leader>hp", function()
        harpoon:list():prev()
      end, {
        desc = "[H]arpoon [P]revious",
      })
      vim.keymap.set("n", "<leader>hn", function()
        harpoon:list():next()
      end, {
        desc = "[H]arpoon [N]ext",
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      }
      -- Oil keymaps
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "folke/which-key.nvim",
    opts = {},
  },
  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  -- Git related plugins
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end,
  },
  -- git diffview
  "sindrets/diffview.nvim",

  "tpope/vim-rhubarb",

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  {
    "kylechui/nvim-surround",
    -- event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "runih/colorscheme-picker.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local ok, colorscheme = pcall(require, "colorscheme-picker")
      if not ok then
        print "Color Picker is not loaded"
        return
      end
      colorscheme.set_default_colorscheme()
    end,
  },
}
