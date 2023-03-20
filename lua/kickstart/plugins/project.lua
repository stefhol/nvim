return {
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      'telescope'
    },
    config = function()
      require('telescope').load_extension('projects')
      require 'telescope'.extensions.projects.projects {}
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
}
