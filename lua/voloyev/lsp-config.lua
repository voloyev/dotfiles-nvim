local lspconfig = require("lspconfig")
local telescope = require("telescope.builtin")
local null_ls = require("null-ls")

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "pyright", "elixirls", "clangd", "solargraph", "gopls", "zls" },
}

lspconfig.pyright.setup()
lspconfig.clangd.setup()
lspconfig.tsserver.setup()
lspconfig.solargraph.setup()
lspconfig.zls.setup()
lspconfig.ocamllsp.setup()
lspconfig.svelte.setup()
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
local elixirlsp_cmd = "elixir_language_server.sh"
lspconfig.elixirls.setup({
  cmd = { elixirlsp_cmd },
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = false,
    },
  },
})

local rust_opts = {
  tools = { -- rust-tools options
    autoSetHints = true,
    runnables = {
      use_telescope = true,
    },

    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
    },

    hover_actions = {
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      auto_focus = false,
    },
  },
}

--require('rust-tools.inlay_hints').toggle_inlay_hints()
require("rust-tools").setup(rust_opts)

require'lspconfig'.lua_ls.setup({
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
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
