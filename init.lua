HOME = os.getenv("HOME")

vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 3 -- always reserve 3 spaces for line number
vim.o.foldcolumn = "1"
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.wrap = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.background = "dark"
vim.o.clipboard = "unnamedplus"
vim.o.modelines = 0
vim.o.showcmd = true

-- Search
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.smartcase = true -- case insentive unless capitals used in search
vim.o.hlsearch = true

vim.o.matchtime = 2 -- delay before showing matching paren
vim.o.mps = vim.o.mps .. ",<:>"

-- White characters
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 2      -- 1 tab = 2 spaces
vim.o.softtabstop = 2  -- 1 tab = 2 spaces
vim.o.shiftwidth = 2   -- indentation rule
vim.o.expandtab = true -- expand tab to spaces

-- basic settings
vim.o.encoding = "utf-8"
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
--vim.o.completeopt = "menuone,noselect"
vim.o.history = 1000
vim.o.dictionary = "/usr/share/dict/words"
vim.o.startofline = true
vim.o.clipboard = "unnamedplus"
-- Display
vim.o.showmatch = true -- show matching brackets
vim.o.scrolloff = 3 -- always show 3 rows from edge of the screen
vim.o.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.o.laststatus = 2 -- always show status line

vim.o.list = false -- do not display white characters
vim.o.foldenable = true
vim.o.foldlevel = 99 -- limit folding to 99 levels
vim.o.foldmethod = "indent" -- use indentation to generate folds
vim.o.wrap = false --do not wrap lines even if very long
vim.o.eol = false -- show if there's no eol char
vim.o.showbreak = "↪" -- character to show when line is broken
vim.o.undodir = HOME .. "/.cache/neovim/undo//"
vim.o.undofile = true
vim.o.cursorline = true
vim.o.termguicolors = true

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
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/sindrets/diffview.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/nvim-pack/nvim-spectre" },
  { src = "https://github.com/dcampos/nvim-snippy" },
  { src = "https://github.com/dcampos/cmp-snippy" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-cmdline" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/ThePrimeagen/harpoon" },
  { src = "https://github.com/FabijanZulj/blame.nvim" },
  { src = "https://github.com/fasterius/simple-zoom.nvim" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

vim.cmd([[colorscheme gruvbox]])

require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
})

require("telescope").setup({
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    file_browser = {
      hidden = { file_browser = true, folder_browser = true },
    },
  },
})

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    "c", "ruby", "python", "elixir", "lua", "rust",
    "lua", "haskell", "javascript", "typescript", "python",
    "ocaml", "html", "svelte", "yaml", "gleam", "terraform",
    "scheme", "clojure", "zig", "go", "hcl", "odin"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  endwise = {
    enable = true,
  },
})

require("persistence").setup()
require("spectre").setup({})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})

require("nvim-autopairs").setup({})
require('mini.surround').setup()
require("ibl").setup()
require('blame').setup({})

local simple_zoom = require("simple-zoom")
vim.keymap.set("n", "<leader>z", simple_zoom.toggle_zoom)


local cmp = require("cmp")
local snippy = require("snippy")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "snippy" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- MagicDuck/grug-far.nvim
require('grug-far').setup({})
vim.keymap.set({ "n" }, "<leader>ss", function()
  require("grug-far").open({ transient = true })
end, { desc = "Toggle Grug Far" })

vim.keymap.set({ "n", "v" }, "<leader>sw", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search current word" })

vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
  require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })
end, { desc = 'grug-far: Search within range' })

require("lualine").setup({
  options = {
    theme = "gruvbox_dark",
    section_separators = '',
    component_separators = '',
    globalstatus = true,
  },
})


require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)


    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)
    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

  end
}

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>qq", ":quitall<CR>")
vim.keymap.set("n", "<Leader>gg", vim.cmd.Neogit)

vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)

-- Lsp keys
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", builtin.lsp_definitions)
vim.keymap.set("n", "gr", builtin.lsp_references)
vim.keymap.set("n", "gi", builtin.lsp_implementations)
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)
vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set({ "v", "n" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end)
vim.keymap.set("n", "<leader>io", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true,
  })
end, { desc = "Organize imports" })


vim.lsp.inlay_hint.enable(true, { 0 })

vim.cmd("set completeopt+=noselect")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config("ansiblels", {
  filetypes = { "yml", "yaml" },
})
vim.lsp.enable('ansiblels')
vim.lsp.enable('gleam')
vim.lsp.enable('html')
vim.lsp.enable('gitlab_ci_ls')
vim.lsp.enable('gh_actions_ls')
-- ty: Fast type checker written in Rust by Astral (same team as Ruff)
vim.lsp.config('ty', {
  capabilities = capabilities,
})
vim.lsp.enable('ty')

-- Ruff: Fast linter and formatter
vim.lsp.config('ruff', {
  capabilities = capabilities,
  init_options = {
    settings = {
      lineLength = 88,
      format = {
        preview = true,
      },
      -- Enable import sorting
      organizeImports = true,
      fixAll = true,
    }
  },
  on_attach = function(client, bufnr)
    -- Disable hover in favor of ty
    client.server_capabilities.hoverProvider = false
  end,
})
vim.lsp.enable('ruff')

vim.lsp.config('clangd', {
  capabilities = capabilities,
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { "-std=c++20" },
    },
  }
})
vim.lsp.enable('clangd')

-- vim.lsp.config('ts_ls', {
--   -- rootdir = lspconfig.util.root_pattern("package.json"),
--   filetypes = {
--     "javascript",
--     "typescript",
--     "vue",
--   },
-- })
vim.lsp.enable('ts_ls')

vim.lsp.config('denols', {
  capabilities = capabilities,
  settings = {
    deno = {
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enable = true },
        enumMemberValues = { enabled = true },
      },
    }
  }
})
vim.lsp.enable('denols')
vim.lsp.enable('solargraph')
vim.lsp.enable('ruby_lsp')

vim.lsp.config('zls', {
  capabilities = capabilities,
  single_file_support = true,
  settings = {
    zls = {
      enable_inlay_hints = true,
      inlay_hints_show_builtin = true,
      inlay_hints_exclude_single_argument = true,
      inlay_hints_hide_redundant_param_names = false,
      inlay_hints_hide_redundant_param_names_last_token = false,
    },
  },
})
vim.lsp.enable('zls')
vim.lsp.enable('ocamllsp')

vim.lsp.config('svelte', {
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})
vim.lsp.enable('svelte')

vim.lsp.enable('templ')
vim.filetype.add({ extension = { templ = "templ" } })

vim.lsp.config('tailwindcss', {
  capabilities = capabilities,
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  init_options = { userLanguages = { templ = "html" } },
})
vim.lsp.enable('tailwindcss')

vim.lsp.config('emmet_ls', {
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
    "react",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
})
vim.lsp.enable('emmet_ls')

vim.lsp.config('gopls', {
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
      },
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable('gopls')
vim.lsp.enable('jsonls')
vim.lsp.config('elixirls', {
  cmd = { "/home/voloyev/w/elixir/elixir-ls/release/language_server.sh" },
})

vim.lsp.enable('elixirls')
vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
      inlayHints = {
        bindingModeHints = {
          enable = false,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = "never",
        },
        lifetimeElisionHints = {
          enable = "never",
          useParameterNames = false,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = "never",
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
    },
  },
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,
  settings = {
    Lua = {
      hint = {
        enable = true,
      }
    }
  },
})
vim.lsp.enable('lua_ls')
vim.lsp.enable('yamlls')
vim.lsp.enable('gitlab_ci_ls')
vim.lsp.enable('gh_actions_ls')

vim.lsp.config('terraformls', {
  capabilities = capabilities,
  filetypes = { "hcl", "terraform", "tf" },
})
vim.lsp.enable('terraformls')

vim.lsp.config('ols', {
  capabilities = capabilities,
  settings = {
    enable_inlay_hints = true,
  },
})
vim.lsp.enable('ols')

vim.filetype.add({
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
    html = "jinja",
  },
})
