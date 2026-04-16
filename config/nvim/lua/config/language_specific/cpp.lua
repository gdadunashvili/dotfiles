local plugin_lib = require('../config/plugin_lib')

--------------------------------------------------------------------------------
-- -------------------------------- C++ ----------------------------------------
--------------------------------------------------------------------------------

-- Header Guard ASSISTANT
--- @return string?
local get_header_guards = function()
    local filetype  = vim.bo.filetype
    local extension = vim.fn.expand('%:e')

    if filetype ~= 'cpp' then return end
    if not (extension == 'h' or extension == 'hpp') then return end

    local filename            = vim.fn.expand('%:t:r')
    local project_file_dir    = string.gsub(vim.fn.expand('%:.:h'), '/', '_')

    local correct_headerguard = string.upper(project_file_dir .. '_' .. filename .. '_' .. extension)

    vim.notify(correct_headerguard)
    vim.fn.setreg('"', correct_headerguard)
    return correct_headerguard
end

local make_headerguard_stub = function()
    local header_guard = get_header_guards()
    local stubs = { '#ifndef ' .. header_guard, '#define ' .. header_guard, '#endif // ' .. header_guard }


    local coordinates = vim.api.nvim_win_get_cursor(0)
    local row = coordinates[1]
    vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, 0, stubs)
end

-- Define an autocommand group for clarity and easy management
vim.api.nvim_create_augroup("CppLocalLeaderMappings", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("CppLocalFunctionality", { clear = false }),
    pattern = { "*.h", "*.hpp" },
    callback = function()
        vim.api.nvim_create_user_command("GetCorrectHeaderGuard", get_header_guards, {})
        vim.api.nvim_create_user_command("InsertHeaderGuardStub", make_headerguard_stub, {})
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>i", "<cmd>InsertHeaderGuardStub<CR>",
            { noremap = true, silent = true })
    end
})

-- Open bazel file in current directory
vim.keymap.set('n', '<localleader>b', function()
    local filedir = vim.fn.expand '%:h'
    local bazel_build_file = filedir .. '/BUILD'
    local file_exists = vim.fn.filereadable(bazel_build_file)
    if file_exists == 1 then
        vim.cmd.edit(bazel_build_file)
    else
        vim.notify('No build file exists in current directory', vim.log.levels.ERROR)
    end
end, { desc = 'Go to [B]azel file in current directory' })
