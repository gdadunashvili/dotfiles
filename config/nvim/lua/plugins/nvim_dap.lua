local function path_subtract(path, base)
    local function normalize(p)
        return p:gsub("\\", "/"):gsub("//+", "/")
    end

    local norm_path = normalize(path)
    local norm_base = normalize(base)

    -- Add trailing slash to base if not present
    if not norm_base:match("/$") then
        norm_base = norm_base .. "/"
    end

    -- Remove the base path from the full path if it exists
    if norm_path:sub(1, #norm_base) == norm_base then
        return norm_path:sub(#norm_base + 1)
    else
        return norm_path
    end
end

return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },

    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        dapui.setup()

        vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, { noremap = true })
        vim.keymap.set('n', '<leader>ds', ":DapNew<CR>", { noremap = true })
        vim.keymap.set('n', '<leader>db', ":DapToggleBreakpoint<CR>", { noremap = true })
        vim.keymap.set('n', '<leader>dc', ":DapContinue<CR>", { noremap = true })
        vim.keymap.set('n', '<leader>dr', function() dapui.open({ reset = true }) end, { noremap = true })
        vim.fn.sign_define('DapBreakpoint',
            { text = '🛑', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        -- vim.keymap.set('n', '<leader>d
        -- instructions from
        -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-gdb

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = vim.fn.stdpath("data") .. '/mason/bin/OpenDebugAD7',
        }

        local py_bin = '/home/linuxbrew/.linuxbrew/bin/python3'

        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or '127.0.0.1'
                cb({
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                        source_filetype = 'python',
                    },
                })
            else
                cb({
                    type = 'executable',
                    command = py_bin,
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
                    },
                })
            end
        end

        local python_config = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}",
                pythonPath = function() return py_bin end,
            },
        }

        -- local current_file = vim.fn.expand('%:p') -- Full path to current file
        local bin_path = function()
            local workspace_folder = vim.fn.getcwd() -- Current working directory (workspace folder)
            local folder_path = vim.fn.expand('%:p:h')

            local cwd = vim.fn.getcwd()
            local filename_no_ext = vim.fn.expand('%:t:r')

            local relative_path = path_subtract(folder_path, cwd)
            vim.notify(relative_path)
            local bin_path = cwd .. "/bazel-bin/" .. relative_path .. "/" .. filename_no_ext
            vim.notify(bin_path)

            return bin_path
        end
        vim.api.nvim_create_user_command("ParentPath", bin_path, {})

        local c_cpp_config = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = true,
                args = {},
            },
            {
                name = "Launch This file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', bin_path(), 'file')
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = true,
                args = {},
            },
            --[[
            {
                name = 'Attach to gdbserver :1234',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:1234',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
            },
            --]]
        }

        dap.configurations.c = c_cpp_config
        dap.configurations.cpp = c_cpp_config
        dap.configurations.python = python_config

        require("nvim-dap-virtual-text").setup {
            enabled = true,                     -- enable this plugin (the default)
            enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
            highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
            highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true,            -- show stop reason when stopped for exceptions
            commented = false,                  -- prefix virtual text with comment string
            only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
            all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
            clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
            --- A callback that determines how a variable is displayed or whether it should be omitted
            --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
            --- @param buf number
            --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
            --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
            --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
            --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
            display_callback = function(variable, buf, stackframe, node, options)
                -- by default, strip out new line characters
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. variable.value:gsub("%s+", " ")
                else
                    return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
                end
            end,
            -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
            virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

            -- experimental features:
            all_frames = true,      -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        }
    end,
}
