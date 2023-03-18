return {
  {
    "theprimeagen/harpoon",
    dependencies = {
    },
    config = function()
      vim.keymap.set('n', '<leader>h', require('harpoon.ui').toggle_quick_menu)
      vim.keymap.set('n', '<leader>m', require('harpoon.mark').add_file)
      require('telescope').load_extension('harpoon')
      require('harpoon').setup({

      })
    end,
  }
}
