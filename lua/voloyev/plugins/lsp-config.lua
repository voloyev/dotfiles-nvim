return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
        },
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set({ "n", "v" }, "<leader>fF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "ts_ls",
          "pyright",
          "elixirls",
          "clangd",
          "solargraph",
          "gopls",
          "zls",
          "templ",
          "svelte",
          "ruby_lsp",
          "html",
          "emmet_ls",
          "jsonls",
          "yamlls",
          "terraformls",
          "ansiblels"
        },
      })

      local lspconfig = require("lspconfig")
      local telescope = require("telescope.builtin")
      local trouble = require("trouble")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
        handlers = {},
      })
      lspconfig.ansiblels.setup({
        capabilities = capabilities,
        filetypes = { "yml", "yaml" }
      })
      lspconfig.gleam.setup({
        capabilities = capabilities,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })

      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
      })

      lspconfig.zls.setup({
        capabilities = capabilities,
      })

      lspconfig.ocamllsp.setup({
        capabilities = capabilities,
      })
      lspconfig.svelte.setup({
        capabilities = capabilities,
      })
      lspconfig.templ.setup({
        capabilities = capabilities,
      })
      vim.filetype.add({ extension = { templ = "templ" } })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } },
      })

      lspconfig.emmet_ls.setup({
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

      lspconfig.gopls.setup({
        capabilities = capabilities,
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
        capabilities = capabilities,
        settings = {
          nim = {
            nimsuggestPath = "~/.nimble/bin/nimlangserver",
          },
        },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
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
      --   settings = {
      --     elixirLS = {
      --       dialyzerEnabled = true,
      --       fetchDeps = false,
      --     },
      --   },
      -- })
      --
      --
      local lexical_cmd = "/home/voloyev/w/elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh"
      lspconfig.lexical.setup({
        capabilities = capabilities,
        cmd = { lexical_cmd },
        settings = {},
      })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = false,
            },
          },
        },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if
              not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
          then
            client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                  },
                },
              },
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end,
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })

      lspconfig.terraformls.setup({
        capabilities = capabilities,
      })

      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "[d", function()
        trouble.next({ skip_groups = true, jump = true })
      end, opts)
      vim.keymap.set("n", "]d", function()
        trouble.previous({ skip_groups = true, jump = true })
      end, opts)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

      local tele_trouble = require("trouble.sources.telescope")
      local tele = require("telescope")
      tele.setup({
        defaults = {
          mappings = {
            i = { ["<c-t>"] = tele_trouble.open },
            n = { ["<c-t>"] = tele_trouble.open },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap = true, silent = true, buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", telescope.lsp_definitions, bufopts)
          vim.keymap.set("n", "gr", telescope.lsp_references, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", telescope.lsp_implementations, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<leader>D", telescope.lsp_type_definitions, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set({ "v", "n" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<leader>F", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)
        end,
      })

      -- TODO: Trouble keymap
      vim.keymap.set("n", "<leader>xx", function()
        trouble.toggle()
      end)
      vim.keymap.set("n", "<leader>xw", function()
        trouble.toggle("workspace_diagnostics")
      end)
      vim.keymap.set("n", "<leader>xd", function()
        trouble.toggle("document_diagnostics")
      end)
      vim.keymap.set("n", "<leader>xq", function()
        trouble.toggle("quickfix")
      end)
      vim.keymap.set("n", "<leader>xl", function()
        trouble.toggle("loclist")
      end)
    end,
  },
}
