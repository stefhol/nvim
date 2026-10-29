local opt = vim.opt

----- Interesting Options -----

-- You have to turn this one on :)
opt.inccommand = "split"

-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true

----- Personal Preferences -----
opt.number = true

opt.splitbelow = true
opt.splitright = true

opt.shada = { "'10", "<0", "s10", "h" }

opt.nu = true
opt.relativenumber = true

-- Default to hard tabs; per-project .editorconfig overrides these
opt.tabstop = 4
opt.softtabstop = -1
opt.shiftwidth = 4
opt.expandtab = false

-- Also detect classic Mac (CR-only) line endings, not just unix/dos
opt.fileformats = { "unix", "dos", "mac" }

opt.smartindent = true
opt.wrap = true

opt.backup = false

opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50
opt.colorcolumn = "80"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.mouse = 'a'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true
