return {
  {
    "natecraddock/workspaces.nvim",
    dependencies = {
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      require("workspaces").setup({
        hooks = {
          open = function()
            require("telescope.builtin").find_files()
          end,
        }
      })
      require('telescope').load_extension "workspaces"
    end
  }
}
