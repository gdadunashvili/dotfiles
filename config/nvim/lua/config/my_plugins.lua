local plugin_lib = require('config/plugin_lib')

-- floating terminal
local central_terminal = function()
    plugin_lib.central_float()
    vim.fn.execute("edit term://zsh")
end

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
-- ---------------------------------- Macros -----------------------------------
--------------------------------------------------------------------------------

plugin_lib.insert_macro({ 'n' }, "F9", "gToDo: ", true)
