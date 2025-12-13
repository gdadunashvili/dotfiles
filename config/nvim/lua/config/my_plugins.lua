local plugin_lib = require('config/plugin_lib')

-- floating terminal
local central_terminal = function()
    plugin_lib.central_float()
    vim.fn.execute("edit term://zsh")
end

vim.keymap.set("n", "<leader>e", central_terminal, {})

-- window resizing
local resize_magnitude = "5"

local horizontal_shrink = function()
    vim.cmd("wincmd " .. resize_magnitude .. "-")
end

local horizontal_grow = function()
    vim.cmd("wincmd " .. resize_magnitude .. "+")
end

local vertical_shrink = function()
    vim.cmd("wincmd " .. resize_magnitude .. "<")
end

local vertical_grow = function()
    vim.cmd("wincmd " .. resize_magnitude .. ">")
end

--- @alias Direction
--- | "h"
--- | "l"
--- | "j"
--- | "k"
--- @param direction Direction
local is_most = function(direction)
    local cur_nr = vim.fn.winnr()
    print(cur_nr)
    vim.cmd("wincmd " .. direction)
    if vim.fn.winnr() == cur_nr then
        return true
    end
    vim.cmd("wincmd p")
    return false
end

local resize_left = function()
    if is_most("h") then
        vertical_shrink()
    end
    if is_most("l") then
        vertical_grow()
    end
end

local resize_right = function()
    if is_most("h") then
        vertical_grow()
    end
    if is_most("l") then
        vertical_shrink()
    end
end


local resize_up = function()
    vim.notify("resize up")
    if is_most("j") then
        horizontal_grow()
    end
    if is_most("k") then
        horizontal_shrink()
    end
end

local resize_down = function()
    vim.notify("resize down")
    if is_most("k") then
        horizontal_grow()
    end
    if is_most("j") then
        horizontal_shrink()
    end
end

vim.keymap.set("n", "<C-M-h>", resize_left)
vim.keymap.set("n", "<C-M-l>", resize_right)
vim.keymap.set("n", "<C-M-k>", resize_up)
vim.keymap.set("n", "<C-M-j>", resize_down)

-- load buffer in quickfix list
local quickfixyfy = function()
    local buffer = vim.fn.getline(1, '$')

    if type(buffer) == "string" then
        buffer = { buffer }
    end

    local qf_list = {}

    local sentence = ""
    for _, line_str in ipairs(buffer) do
        local words = plugin_lib.split_to_words(line_str)
        for _, word in ipairs(words) do
            local file, line, col = plugin_lib.make_into_destination_if_possible(word)
            if (file == nil) then
                sentence = sentence .. ' ' .. word
            else
                table.insert(qf_list, {
                    text = sentence,
                })
                sentence = ""
                table.insert(qf_list, {
                    filename = file,
                    lnum = line,
                    cnum = col,
                }
                )
            end
        end
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.cmd("copen")
end

vim.api.nvim_create_user_command("Quickfixify", quickfixyfy, {})


vim.api.nvim_create_user_command("Openscratch", function() vim.cmd("vsplit ~/Documents/vimscratch.md") end
, {})

--- bazel execution


vim.api.nvim_create_user_command("ClipCurrentFilePath", function() vim.fn.setreg('+', vim.fn.expand('%:.')) end, {})

--[[
local  bazel_run = function()
    -- this function is intended to put a clickable run symbol in the gatter inside a bazel file
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand('%:t:r')
    local filedir  = vim.fn.expand('%:h')
    if filetype ~= 'bzl' or filename ~= 'BUILD' then vim.notify("nope") end
    vim.notify(filetype)
    local pos = vim.api.nvim_win_get_cursor(0)
    local line_nr = pos[1]
    -- local col_nr = pos[2]
    plugin_lib.put_char_in_gutter(0, line_nr-1, " ")
end
vim.api.nvim_create_user_command("BazelRun", bazel_run, {})
--]]
--------------------------------------------------------------------------------
-- ------------------------ Language related plugins ---------------------------
--------------------------------------------------------------------------------



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
--[[
vim.api.nvim_create_autocmd("BufEnter", {
    group = "HeaderGuards",
    pattern = { "*.h", "*.hpp" },
    command = "CheckHeaderGuards"
})
--]]


--------------------------------------------------------------------------------
---------------------------------    Lua   -------------------------------------
--------------------------------------------------------------------------------

---@param code string
local function execute_lua_code(code)
    local func, err = load(code)
    if not func then
        vim.notify("Provided text is not valid Lua code: " .. err)
        return
    end
    local ok, result = pcall(func)
    if not ok then
        vim.notify("Runtime error: " .. err)
    else
        if result ~= nil then
            vim.inspect(result)
        end
    end
end

-- Function to execute the current line as Lua code
local function exec_line_as_lua()
    local line = vim.api.nvim_get_current_line() -- Get the current line under the cursor
    execute_lua_code(line)
end

local function exec_selection_as_lua()
    local selection = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"))
    local result = table.concat(selection, "\n")
    execute_lua_code(result)
end

vim.api.nvim_create_user_command('ExecLineAsLua', exec_line_as_lua, {})
vim.api.nvim_create_user_command('ExecSelectionAsLua', exec_selection_as_lua, {})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("LueLocalFunctionality", { clear = false }),
    pattern = "*.lua",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>e", "<cmd>ExecLineAsLua<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "v", "<localleader>e", ":ExecSelectionAsLua<CR>",
            { noremap = true, silent = true })
    end
})

--------------------------------------------------------------------------------
--------------------------------- Markdown -------------------------------------
--------------------------------------------------------------------------------


local insert_bulletpoint = function()
    local stubs = { '- [ ] ' }

    local coordinates = vim.api.nvim_win_get_cursor(0)
    local row = coordinates[1]
    vim.cmd('norm o')
    vim.api.nvim_buf_set_text(0, row, 0, row, 0, stubs)
    vim.cmd('norm A')
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("MarkdownLocalFunctionality", { clear = false }),
    pattern = { "*.md" },
    callback = function()
        vim.keymap.set("n", "<localleader>o", insert_bulletpoint,
            { noremap = true, silent = true })
    end
})
