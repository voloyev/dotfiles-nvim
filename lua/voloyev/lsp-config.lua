local lspconfig = require("lspconfig")
local telescope = require("telescope.builtin")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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
  vim.keymap.set("n", "<leader>F", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.solargraph.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.zls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
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

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local elixirlsp_cmd = "elixir_language_server.sh"

lspconfig.elixirls.setup({
  cmd = { elixirlsp_cmd },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      -- I choose to disable dialyzer for personal reasons, but
      -- I would suggest you also disable it unless you are well
      -- aquainted with dialzyer and know how to use it.
      dialyzerEnabled = true,
      -- I also choose to turn off the auto dep fetching feature.
      -- It often get's into a weird state that requires deleting
      -- the .elixir_ls directory and restarting your editor.
      fetchDeps = false,
    },
  },
})

local rust_opts = {
  on_attach = on_attach,
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

  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  }, -- rust-analyer options
}

--require('rust-tools.inlay_hints').toggle_inlay_hints()
require("rust-tools").setup(rust_opts)

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          format = {
            enable = true,
            -- Put format options here
            -- NOTE: the value should be STR:wqING!!
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          }
        }
      })

      client.notify("workspace/didChangeConfiguration",
        { settings = client.config.settings, capabilities = capabilities })
    end
    return true
  end
})

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.nim_langserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    nim = {
      nimsuggestPath = "~/.nimble/bin/nimlangserver"
    }
  }
})

lspconfig.ocamllsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})


lspconfig.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
--
-- null_ls.setup({
-- 	sources = {
-- 		null_ls.builtins.formatting.stylua,
-- 		null_ls.builtins.diagnostics.eslint,
-- 		null_ls.builtins.completion.spell,
-- 		null_ls.builtins.code_actions.shellcheck,
-- 		null_ls.builtins.code_actions.eslint,
-- 		null_ls.builtins.code_actions.gitsigns,
-- 		null_ls.builtins.code_actions.xo,
-- 		null_ls.builtins.diagnostics.credo,
-- 		null_ls.builtins.diagnostics.erb_lint,
-- 		null_ls.builtins.diagnostics.flake8,
-- 		null_ls.builtins.diagnostics.hadolint,
-- 		null_ls.builtins.diagnostics.rubocop,
-- 		null_ls.builtins.diagnostics.eslint,
-- 		null_ls.builtins.formatting.clang_format,
-- 		null_ls.builtins.formatting.eslint,
-- 		null_ls.builtins.diagnostics.clang_check,
-- 	},
-- })
