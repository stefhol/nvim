return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
      { "nvim-telescope/telescope-fzf-native.nvim",   build = "make" },
      { "nvim-telescope/telescope-smart-history.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require "custom.telescope"
    end,
  },
}
