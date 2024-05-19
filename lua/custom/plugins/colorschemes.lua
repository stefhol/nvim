-- ... this file is filled with pain

return {
  {
    dir = "~/plugins/colorbuddy.nvim",
  },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
}
