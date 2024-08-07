local dap = require('dap')
local dapui = require('dapui')
dapui.setup()

vim.keymap.set('n', '<leader>dt', function () dapui.toggle() end, {noremap=true})
vim.keymap.set('n', '<leader>db', ":DapToggleBreakpoint<CR>", {noremap=true})
vim.keymap.set('n', '<leader>dc', ":DapContinue<CR>", {noremap=true})
vim.keymap.set('n', '<leader>dr', function () require("dapui").open({reset=true}) end, {noremap=true})
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
-- vim.keymap.set('n', '<leader>d


-- instructions from
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-gdb

dap.adapters.codelldb ={
    type = 'server',
    port = "${port}",
    executable ={
        command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
        args = {"--port", "${port}" }
    }

}

 local c_cpp_config = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = c_cpp_config
dap.configurations.cpp = c_cpp_config
