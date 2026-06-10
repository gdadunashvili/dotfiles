local plugin_lib = require('config/plugin_lib')

--- @return string?
local get_current_bazel_root = function()
    local cmd_str = "!bazel info workspace"
    local execution_result = vim.api.nvim_exec2(cmd_str, { output = true })
    local output = execution_result.output
    if output == nil or output:len() == 0 then
        return
    end

    local bazel_match_single_line = string.gmatch(output, "\n(.+)\n")
    local cleand_path_string      = bazel_match_single_line()

    if cleand_path_string == nil or cleand_path_string:len() == 0 then return end
    cleand_path_string = cleand_path_string:gsub('\n', '')
    if cleand_path_string == nil or cleand_path_string:len() == 0 then return end

    return cleand_path_string
end

--- @param file_containing_directory_path string
--- @return string?
local get_bazel_targets = function(file_containing_directory_path)
    local bazel_root = get_current_bazel_root()

    if bazel_root == nil then
        vim.notify("Failed to get bazel workspace root")
        return
    end

    local bazel_directory_level_query_string = file_containing_directory_path:gsub(bazel_root, '/') .. '/...'

    local query_str = "!bazel query " .. bazel_directory_level_query_string
    local targets = vim.api.nvim_exec2(query_str, { output = true }).output
    return targets
end

--- @param file_containing_directory_path string
local buffered_bazel_lines_to_telescope = function(file_containing_directory_path)
    local linebuf = get_bazel_targets(file_containing_directory_path)
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
                    vim.fn.setreg('+', selection)
                end
            end)
            return true
        end
    }):find()
end

-- Create a user command
vim.api.nvim_create_user_command('GetBazelTargetsInFolder', function()
    local file_containing_directory_path = vim.fn.expand('%:p:h')
    file_containing_directory_path = file_containing_directory_path:gsub("^oil://", "")
    buffered_bazel_lines_to_telescope(file_containing_directory_path)
end, {})

vim.api.nvim_create_user_command('GetBazelTargetsAll', function()
    local root_path = vim.fn.getcwd()
    buffered_bazel_lines_to_telescope(root_path)
end, {})

vim.keymap.set("n", "<F8>", function() vim.cmd("GetBazelTargetsInFolder") end)
vim.keymap.set("n", "<F9>", function() vim.cmd("GetBazelTargetsAll") end)

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
    if is_most("j") then
        horizontal_grow()
    end
    if is_most("k") then
        horizontal_shrink()
    end
end

local resize_down = function()
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

vim.api.nvim_create_user_command("Openscratch", function()
    plugin_lib.central_float()
    vim.cmd("edit ~/Documents/vimscratch.md")
end
, {})

vim.keymap.set("n", "<leader>e", ":Openscratch<cr>")
--- bazel execution


vim.api.nvim_create_user_command("ClipCurrentFilePath", function() vim.fn.setreg('+', vim.fn.expand('%:.')) end, {})
vim.keymap.set("n", "<leader>cf", ":ClipCurrentFilePath<cr>")


--------------------------------------------------------------------------------
-- ---------------------------------- Macros -----------------------------------
--------------------------------------------------------------------------------

-- inject todo
local insert_thing = function(stub_core)
    return function()
        local stubs = { stub_core .. ':  ' }

        local coordinates = vim.api.nvim_win_get_cursor(0)
        local row = coordinates[1]
        vim.api.nvim_command('normal! O')
        vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, 0, stubs)
        vim.cmd('norma gcc')
        vim.cmd('norma A')
        vim.api.nvim_command('startinsert')
    end
end

vim.keymap.set("n", "<leader>it", insert_thing("gToDo"), {})
vim.keymap.set("n", "<leader>ip", insert_thing("PERF"), {})
vim.keymap.set("n", "<leader>iw", insert_thing("WARN"), {})
vim.keymap.set("n", "<leader>in", insert_thing("NOTE"), {})

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
