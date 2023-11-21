HOME = os.getenv("HOME")
-- Set a leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.showmatch = true
vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- basic settings
vim.opt.encoding = "utf-8"
vim.opt.backspace = "indent,eol,start" -- backspace works on every char in insert mode
--vim.opt.completeopt = "menuone,noselect"
vim.opt.history = 1000
vim.opt.dictionary = "/usr/share/dict/words"
vim.opt.startofline = true

-- Display
vim.opt.showmatch = true -- show matching brackets
vim.opt.scrolloff = 3 -- always show 3 rows from edge of the screen
vim.opt.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.opt.laststatus = 2 -- always show status line

vim.opt.list = false -- do not display white characters
vim.opt.foldenable = false
vim.opt.foldlevel = 4 -- limit folding to 4 levels
vim.opt.foldmethod = "syntax" -- use language syntax to generate folds
vim.opt.wrap = false --do not wrap lines even if very long
vim.opt.eol = false -- show if there's no eol char
vim.opt.showbreak = "↪" -- character to show when line is broken

-- Sidebar
vim.opt.number = true      -- line number on the left
vim.opt.numberwidth = 3    -- always reserve 3 spaces for line number
vim.opt.signcolumn = "yes" -- keep 1 column for coc.vim  check
vim.opt.modelines = 0
vim.opt.showcmd = true     -- display command in bottom bar

-- Search
vim.opt.incsearch = true -- starts searching as soon as typing, without enter needed
vim.opt.smartcase = true -- case insentive unless capitals used in search
vim.opt.hlsearch = false

vim.opt.matchtime = 2 -- delay before showing matching paren
vim.opt.mps = vim.o.mps .. ",<:>"

-- White characters
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2            -- 1 tab = 2 spaces
vim.opt.softtabstop = 2        -- 1 tab = 2 spaces
vim.opt.shiftwidth = 2         -- indentation rule
vim.opt.expandtab = true       -- expand tab to spaces
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99


vim.opt.laststatus = 2

--setup backups
vim.opt.backupdir = HOME .. "/.cache/neovim/backup//"
vim.opt.directory = HOME .. "/.cache/neovim/swap//"
vim.opt.undodir = HOME .. "/.cache/neovim/undo//"
vim.opt.undofile = true
vim.opt.cursorline = true

vim.opt.termguicolors = true
-- lualine
require("lualine").setup({
  options = {
    theme = "auto",
  },
})


require("ibl").setup()
  -- for example, context is off by default, use this to turn it on
 -- show_current_context = true,
  --show_current_context_start = true,
  --char_highlight_list = {"IndentBlanklineIndent1"}

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', '<leader>hf', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', '<leader>hF', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', '<leader>ht', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', '<leader>hT', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
