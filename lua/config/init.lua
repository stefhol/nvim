vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.backup = false

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- neovide config
if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    if vim.fn.has('macunix') then
        vim.keymap.set("n", "<D-=>", function()
            change_scale_factor(1.25)
        end)
        vim.keymap.set("n", "<D-->", function()
            change_scale_factor(1 / 1.25)
        end)
        vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
        vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
        vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
        vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
        vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
        vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
        vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    else
        vim.keymap.set("n", "<C-=>", function()
            change_scale_factor(1.25)
        end)
        vim.keymap.set("n", "<C-->", function()
            change_scale_factor(1 / 1.25)
        end)
    end
end
