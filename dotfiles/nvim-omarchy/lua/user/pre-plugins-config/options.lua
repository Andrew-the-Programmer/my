My.opts = {}

vim.opt.nu = true
vim.opt.relativenumber = false

-- Default tabs & indentation
-- See user.filetype_specific
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
-- vim.opt.breakindent = true

-- Disable text wrap
vim.opt.wrap = false

-- Enable mouse mode
vim.opt.mouse = "a"

-- Disable showing the mode below the statusline
vim.opt.showmode = false

-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set completeopt to have a better completion experience
-- NOTE: Results in strange error in arch linux.
-- vim.opt.completeopt = { "menu", "menuone", "noselect", "preview", "popup", "fuzzy" }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

-- Place a column line
vim.opt.colorcolumn = "80"

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.cursorline = true -- highlight the current cursor line

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- backspace
-- vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
-- vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Enable access to System Clipboard
-- vim.opt.clipboard = "unnamed,unnamedplus"

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- Default term shell
vim.opt.shell = "/bin/zsh"

-- To source ./.nvim.lua file after nvim launch
vim.o.exrc = true

-- vim.opt.spelllang = { "en_us", "ru_ru" }
-- vim.opt.spelllang = { "en_us", "ru" }
-- vim.opt.spelllang = "en_us"
vim.opt.spell = true
-- vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/ru.utf-8.spl")

vim.env.PATH = "/home/andrew/.local/bin:" .. vim.env.PATH
vim.env.PATH = "/home/andrew/.nvm:" .. vim.env.PATH
vim.env.PATH = "/home/andrew/.nvm/versions/node/v22.7.0/bin:" .. vim.env.PATH

vim.lsp.set_log_level("off")

vim.opt.timeoutlen = 40
