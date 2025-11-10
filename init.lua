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
})

vim.cmd([[colorscheme gruvbox]])

require("oil").setup()

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

-- require("persistence").setup()
require("spectre").setup({})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
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
vim.keymap.set("n", "<leader>ww", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)
vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set({ "v", "n" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end)


vim.lsp.inlay_hint.enable(true, { 0 })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end
})

vim.lsp.config("ansiblels", {
  filetypes = { "yml", "yaml" },
})
vim.lsp.enable('ansiblels')
vim.lsp.enable('gleam')
vim.lsp.enable('html')
vim.lsp.enable('gitlab_ci_ls')
vim.lsp.enable('gh_actions_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('pyrefly')
vim.lsp.config('pylyzer', {
  settings = {
    python = {
      inlayHints = true,
    },
  },
})
vim.lsp.enable('pylyzer')
vim.lsp.enable('ruff')

vim.lsp.config('clangd', {
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
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  init_options = { userLanguages = { templ = "html" } },
})
vim.lsp.enable('tailwindcss')

vim.lsp.config('emmet_ls', {
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
  filetypes = { "hcl", "terraform", "tf" },
})
vim.lsp.enable('terraformls')

vim.lsp.config('ols', {
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
