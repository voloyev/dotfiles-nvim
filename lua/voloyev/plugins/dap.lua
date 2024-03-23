return {
  "leoluz/nvim-dap-go",
  "theHamsta/nvim-dap-virtual-text",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()


      dap.configurations.ruby = {
        {
          type = 'ruby',
          name = 'debug current file',
          bundle = '',
          request = 'attach',
          command = "ruby",
          script = "${file}",
          port = 38698,
          server = '127.0.0.1',
          options = {
            source_filetype = 'ruby',
          },
          localfs = true,
          waiting = 1000,
        },
        {
          type = 'ruby',
          name = 'run rspec current_file',
          bundle = 'bundle',
          request = 'attach',
          command = "rspec",
          script = "${file}",
          port = 38698,
          server = '127.0.0.1',
          options = {
            source_filetype = 'ruby',
          },
          localfs = true,
          waiting = 1000,
        },
        {
          type = 'ruby',
          name = 'run rspec current_file:current_line',
          bundle = 'bundle',
          request = 'attach',
          command = "rspec",
          script = "${file}",
          port = 38698,
          server = '127.0.0.1',
          options = {
            source_filetype = 'ruby',
          },
          localfs = true,
          waiting = 1000,
          current_line = true,
        },
        {
          type = 'ruby',
          name = 'run rspec',
          bundle = 'bundle',
          request = 'attach',
          command = "rspec",
          script = "./spec",
          port = 38698,
          server = '127.0.0.1',
          options = {
            source_filetype = 'ruby',
          },
          localfs = true,
          waiting = 1000,
        },
        {
          type = 'ruby',
          name = 'rails service',
          bundle = 'bundle',
          request = 'attach',
          command = "rails s -p 3002",
          script = "",
          port = 38698,
          server = '127.0.0.1',
          options = {
            source_filetype = 'ruby',
          },
          localfs = true,
          waiting = 1000,
        },
      }


      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      --[[dap.listeners.before.event_terminated["dapui_config"] = function()]]
      --[[dapui.close()]]
      --[[end]]
      --[[dap.listeners.before.event_exited["dapui_config"] = function()]]
      --[[dapui.close()]]
      --[[end]]

      vim.keymap.set("n", "<leader>dt", dapui.open, { noremap = true })
      vim.keymap.set("n", "<leader>dq", dapui.close, { noremap = true })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true })
      vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true })
      vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true })
      vim.keymap.set("n", "<leader>do", dap.step_over, { noremap = true })

      require('dap-go').setup({})
      require('nvim-dap-virtual-text').setup({})
    end
  }
}
