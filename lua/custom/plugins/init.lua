return {

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
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
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
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
