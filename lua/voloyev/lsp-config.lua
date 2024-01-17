require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "pyright", "elixirls", "clangd", "solargraph", "gopls", "zls", "templ", "svelte" },
})

local lspconfig = require("lspconfig")
local telescope = require("telescope.builtin")
local trouble = require("trouble")
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.credo,
    null_ls.builtins.diagnostics.erb_lint,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.clang_check,
  },
})

require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true,
})

lspconfig.pyright.setup({})
lspconfig.clangd.setup({})
lspconfig.tsserver.setup({})
lspconfig.solargraph.setup({})
lspconfig.zls.setup({})
lspconfig.ocamllsp.setup({})
lspconfig.svelte.setup({})
lspconfig.templ.setup({})
vim.filetype.add({ extension = { templ = "templ" } })
lspconfig.tailwindcss.setup({
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
})

lspconfig.emmet_ls.setup({
  filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  }
})

lspconfig.gopls.setup({
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

lspconfig.nim_langserver.setup({
  settings = {
    nim = {
      nimsuggestPath = "~/.nimble/bin/nimlangserver"
    }
  }
})

--
-- require("elixir").setup({
--   nextls = {enable = false},
--   credo = {enable = true},
--   elixirls = {enable = true},
-- })
--
-- local elixirlsp_cmd = "elixir_language_server.sh"
--
-- lspconfig.elixirls.setup({
--   cmd = { elixirlsp_cmd },
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     elixirLS = {
--       -- I choose to disable dialyzer for personal reasons, but
--       -- I would suggest you also disable it unless you are well
--       -- aquainted with dialzyer and know how to use it.
--       dialyzerEnabled = true,
--       -- I also choose to turn off the auto dep fetching feature.
--       -- It often get's into a weird state that requires deleting
--       -- the .elixir_ls directory and restarting your editor.
--       fetchDeps = false,
--     },
--   },
-- })
--
--
local lexical_cmd = "~/Applications/lexical/_build/dev/package/lexical/bin/start_lexical.sh"
lspconfig.lexical.setup({
  cmd = { lexical_cmd },
  settings = {},
})

lspconfig.rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
})

lspconfig.lua_ls.setup({
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
})
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", telescope.lsp_definitions, bufopts)
    vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<leader>gi", telescope.lsp_implementations, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", telescope.lsp_type_definitions, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>gr', telescope.lsp_references, bufopts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>F", function()
      vim.lsp.buf.format({ async = true })
    end, bufopts)
  end
})


-- TODO: Trouble keymap
vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)


-- require('lint').linters_by_ft = {
--   markdown = { 'vale', },
--   typescript = { 'eslint', },
--   javascript = { 'eslint', },
--   ruby = { 'rubocop', },
--   elixir = { 'credo', },
-- }

--
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
--

