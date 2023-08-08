return {
  {
    "theprimeagen/harpoon",
    dependencies = {
    },
    config = function()
      vim.keymap.set('n', '<leader>h', require('harpoon.ui').toggle_quick_menu, { desc = 'Toggle Harpoon Ui' })
      vim.keymap.set('n', '<leader>m', require('harpoon.mark').add_file, { desc = 'Add file to Harpoon' })
      require('telescope').load_extension('harpoon')
      require('harpoon').setup({

      })
    end,
  }
}
