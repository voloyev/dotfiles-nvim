local telescope = require('telescope.builtin')
local hop = require('hop')
local directions = require('hop.hint').HintDirection

-- Set a leader key
vim.cmd('noremap <C-p> :noh<cr>') -- clear matches Ctrl+b

local function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

local function cmap(shortcut, command)
  map('c', shortcut, command)
end

local function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- sane regexes
nmap('/', '/\\v')
vmap('/', '/\\v')

-- don't jump when using *
nmap('*', '*<c-o>')

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Same when jumping around
nmap('g;', 'g;zz')
--nmap('g', 'g,zz') -- for some reason doesn't work well

-- Open a Quickfix window for the last search.
nmap("<leader>?", ":execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>")

-- Begining & End of line in Normal mode
nmap('H', '^')
nmap('L', 'g_')

-- more natural movement with wrap on
nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

-- Easy buffer navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Reselect visual block after indent/outdent
vmap('<', '<gv')
vmap('>', '>gv')

-- home and end line in command mode
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')

-- Terminal
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- Easy window split; C-w v -> vv, C-w - s -> ss
nmap('vv', '<C-w>v')
nmap('ss', '<C-w>s')
vim.opt.splitbelow = true -- when splitting horizontally, move coursor to lower pane
vim.opt.splitright = true -- when splitting vertically, mnove coursor to right pane

-- PLUGINS

-- git
nmap('<Leader><C-g>', '<cmd>Git<cr>')

-- nerdtree
nmap('<leader>nn', '<cmd>NERDTreeFocus<cr>')
nmap('<leader>nt', '<cmd>NERDTree<cr>')

vim.keymap.set('n', '<leader>e', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR,
  current_line_only = true })
end, {remap=true})

vim.keymap.set('n', '<leader>E', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR,
  current_line_only = true })
end, {remap=true})

vim.keymap.set('n', '<leader>t', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR,
  current_line_only = true, hint_offset = -1 })
end, {remap=true})

vim.keymap.set('n', '<leader>T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR,
  current_line_only = true, hint_offset = 1 })
end, {remap=true})


nmap('<leader><leader>', telescope.find_files)
nmap('<leader>og', telescope.live_grep)
nmap('<leader>ob', telescope.buffers)
nmap('<leader>oh', telescope.help_tags)
nmap('<leader>gd', telescope.lsp_definitions)
nmap('<Leader>gr', telescope.lsp_references)
