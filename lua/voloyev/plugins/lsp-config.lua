return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier", "eslint" },
          ruby = { "rubocop" },
          go = { "gofmt" },
        },
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set({ "n", "v" }, "<leader>F", function()
        conform.format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local telescope = require("telescope.builtin")
      local trouble = require("trouble")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.ansiblels.setup({
        capabilities = capabilities,
        filetypes = { "yml", "yaml" },
      })
      lspconfig.gleam.setup({
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
        root_dir = lspconfig.util.root_pattern("package.json"),
      })

      lspconfig.denols.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })

      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })

      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
      })

      lspconfig.zls.setup({
        capabilities = capabilities,
        single_file_support = true,
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
      lspconfig.lexical.setup({
        capabilities = capabilities,
        root_dir = function(fname)
          return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
        end,
        filetypes = { "elixir", "eelixir", "heex" },
        -- optional settings
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
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              },
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })

      lspconfig.terraformls.setup({
        capabilities = capabilities,
      })

      lspconfig.jinja_lsp.setup({
        capabilities = capabilities,
        init_options = {
          templates = "/Users/Volodymyr_Yevtushenko/w/PELO/api/cms/templates",
          backend = { "/Users/Volodymyr_Yevtushenko/w/PELO/api/" },
          lang = "python",
        },
      })

      lspconfig.harper_ls.setup({
        settings = {
          ["harper-ls"] = {
            userDictPath = "",
            fileDictPath = "",
            linters = {
              SpellCheck = true,
              SpelledNumbers = false,
              AnA = true,
              SentenceCapitalization = true,
              UnclosedQuotes = true,
              WrongQuotes = false,
              LongSentences = true,
              RepeatedWords = true,
              Spaces = true,
              Matcher = true,
              CorrectNumberSuffix = true,
            },
            codeActions = {
              ForceStable = false,
            },
            markdown = {
              IgnoreLinkTitle = false,
            },
            diagnosticSeverity = "hint",
            isolateEnglish = false,
          },
        },
      })

      require("lspconfig").ols.setup({
        capabilities = capabilities,
      })

      vim.filetype.add({
        extension = {
          jinja = "jinja",
          jinja2 = "jinja",
          j2 = "jinja",
          html = "jinja",
        },
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
          vim.keymap.set("n", "<leader>ww", vim.diagnostic.open_float, bufopts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<leader>D", telescope.lsp_type_definitions, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set({ "v", "n" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)
        end,
      })
    end,
  },
}
