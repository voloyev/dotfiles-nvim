-- sane regexes
--vim.keymap.set("n",'/', '/\\v')
--vim.keymap.set("v",'/', '/\\v')

-- don't jump when using *
vim.keymap.set("n", "*", "*<c-o>")

-- keep search matches in the middle of the window
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Same when jumping around
vim.keymap.set("n", "g;", "g;zz")
--nmap('g', 'g,zz') -- for some reason doesn't work well

-- Open a Quickfix window for the last search.
vim.keymap.set("n", "<leader>?", ":execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>")

-- Begining & End of line in Normal mode
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "g_")

-- more natural movement with wrap on
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

-- Easy buffer navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Reselect visual block after indent/outdent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- home and end line in command mode
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")

-- Terminal
-- ESC to go to normal mode in terminal
vim.keymap.set("t", "<C-s>", "<C-\\><C-n>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Easy window split; C-w v -> vv, C-w - s -> ss
vim.keymap.set("n", "vv", "<C-w>v")
vim.keymap.set("n", "ss", "<C-w>s")
vim.opt.splitbelow = true -- when splitting horizontally, move coursor to lower pane
vim.opt.splitright = true -- when splitting vertically, mnove coursor to right pane

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>/", ":nohl<CR>")
