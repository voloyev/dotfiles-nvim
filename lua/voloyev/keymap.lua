local telescope = require("telescope.builtin")
local hop = require("hop")
local directions = require("hop.hint").HintDirection

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

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'")

-- PLUGINS

-- git
vim.keymap.set("n", "<Leader>gg", vim.cmd.Git)

-- nerdtree
vim.keymap.set("n", "<leader>nn", vim.cmd.NERDTreeFocus)
vim.keymap.set("n", "<leader>nt", vim.cmd.NERDTree)

--undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>e", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })

vim.keymap.set("n", "<leader>E", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })

vim.keymap.set("n", "<leader>t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })

vim.keymap.set("n", "<leader>T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

vim.keymap.set("n", "<leader><leader>", telescope.find_files)
vim.keymap.set("n", "<C-p>", telescope.git_files)
vim.keymap.set("n", "<leader>ff", telescope.live_grep)
vim.keymap.set("n", "<leader>ob", telescope.buffers)
vim.keymap.set("n", "<leader>oh", telescope.help_tags)
vim.keymap.set("n", "<leader>gd", telescope.lsp_definitions)
vim.keymap.set("n", "gr", telescope.lsp_references)
