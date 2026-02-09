local plugin_lib = require('../config/plugin_lib')

--------------------------------------------------------------------------------
-- -------------------------------- C++ ----------------------------------------
--------------------------------------------------------------------------------

--- @return string?
local get_bazel_targets = function()
    local filedir     = vim.fn.expand('%:p:h')
    -- if filetype ~= 'bzl' or filename ~= 'BUILD' then vim.notify("nope") end
    local cmd_str     = "!bazel info workspace"
    local output      = vim.api.nvim_exec2(cmd_str, { output = true })
    local bazel_match = string.gmatch(output.output, "\n(.+)\n")
    local res         = bazel_match()
    if res == nil or res:len() == 0 then return end
    res = res:gsub('\n', '')
    if res == nil or res:len() == 0 then return end
    local bazel_folder = filedir:gsub(res, '/') .. '/...'

    local query_str = "!bazel query " .. bazel_folder
    local targets = vim.api.nvim_exec2(query_str, { output = true }).output
    return targets
end

local buffered_bazel_lines_to_telescope = function()
    local linebuf = get_bazel_targets()
    if linebuf == nil then return end
    local lines = plugin_lib.linewise(linebuf)

    -- Create entries for telescope
    local results = {}
    local i = 0
    for line in lines do
        if line == "" then goto continue end
        local pos = string.find(line, "//")
        if pos == nil or pos > 1 then goto continue end

        table.insert(results, {
            value = line,
            ordinal = line,              -- Used for sorting and filtering
            display = i .. ": " .. line, -- What will be displayed in telescope
            filename = '',
            lnum = i
        })
        i = i + 1
        ::continue::
    end

    -- Load telescope
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- Create the picker
    pickers.new({}, {
        prompt_title = "Buffer Lines",
        finder = finders.new_table({
            results = results,
            entry_maker = function(entry)
                return {
                    value = entry,
                    ordinal = entry.ordinal,
                    display = entry.display,
                    filename = entry.filename,
                    lnum = entry.lnum
                }
            end
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            -- Define custom action when selecting an entry
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection ~= nil then
                    selection = selection.value.value
                    vim.fn.setreg('"', selection)
                    vim.fn.setreg('"+', selection)
                end
            end)
            return true
        end
    }):find()
end

-- Create a user command
vim.api.nvim_create_user_command('GetBazelTargets', function()
    buffered_bazel_lines_to_telescope()
end, {})

vim.keymap.set("n", "<F8>", buffered_bazel_lines_to_telescope)


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
