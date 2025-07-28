local plugin_lib = require('config/plugin_lib')

-- floating terminal
local function central_terminal()
    plugin_lib.central_float()
    vim.fn.execute("edit term://zsh")
end

vim.keymap.set("n", "<leader>e", central_terminal, {} )

-- window resizing
local resize_magnitude = "5"

local function horizontal_shrink()
    vim.cmd("wincmd "..resize_magnitude.."-")
end

local function horizontal_grow()
    vim.cmd("wincmd "..resize_magnitude.."+")
end

local function vertical_shrink()
    vim.cmd("wincmd "..resize_magnitude.."<")
end

local function vertical_grow()
    vim.cmd("wincmd "..resize_magnitude..">")
end

--- @alias Direction
--- | "h"
--- | "l"
--- | "j"
--- | "k"
--- @param direction Direction
local function is_most(direction)
    local cur_nr = vim.fn.winnr()
    print(cur_nr)
    vim.cmd("wincmd "..direction)
    if vim.fn.winnr() == cur_nr then
        return true
    end
    vim.cmd("wincmd p")
    return false
end

local function resize_left()
    if is_most("h") then
        vertical_shrink()
    end
    if is_most("l") then
        vertical_grow()
    end
end

local function resize_right()
    if is_most("h") then
        vertical_grow()
    end
    if is_most("l") then
        vertical_shrink()
    end
end


local function resize_up()
    vim.notify("resize up")
    if is_most("j") then
        horizontal_grow()
    end
    if is_most("k") then
        horizontal_shrink()
    end
end

local function resize_down()
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
local function quickfixyfy()
    local buffer = vim.fn.getline(1,'$')

    if type(buffer) == "string" then
        buffer = {buffer}
    end

    --- @type vim.quickfix.entry[]
    local qf_list = {}

    for _, line_str in ipairs(buffer) do
        local file, line, col, text = plugin_lib.extract_destination(line_str)
        if file == nil then goto continue end
        local trunc_text = ""
        if text:len() > 120 then
            trunc_text = text:sub(1, 120)
        else
            trunc_text = text
        end
        table.insert(qf_list, {
            filename = file,
            lnum = line,
            cnum = col,
            text = trunc_text,
            }
        )
        ::continue::
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.cmd("copen")

end

vim.api.nvim_create_user_command("Quickfixify", quickfixyfy, {} )


--- bazel execution

local function extract_all_executabel_names(buffer)
    local buffer = vim.fn.getline(1,'$')

    if type(buffer) == "string" then
        buffer = {buffer}
    end

        -- "" "" '󱁤' '󰖷' "🐞" ▶️ 🔨
    for line_nr, line_str in ipairs(buffer) do
        local bazel_symbol, type = plugin_lib.extract_destination(line_str)

        local glyph = ""
        if type == 'build' then glyph='󱁤' end
        if type == 'run' then glyph='' end
        if type == 'test' then glyph='' end
        if type == 'debug' then glyph=' ' end
        -- gToDo: execute bazel query to get the full target string for a symbol
        plugin_lib.put_char_in_gutter(0, line_nr-1, glyph)
        if symbol == nil then goto continue end



        ::continue::
    end
end

local function bazel_run()
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



local function get_bazel_targets()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand('%:t:r')
    local filedir  = vim.fn.expand('%:p:h')
    if filetype ~= 'bzl' or filename ~= 'BUILD' then vim.notify("nope") end
    local cmd_str = "!bazel info workspace"
    local output = vim.api.nvim_exec2(cmd_str, {output = true})
    local bazel_match = string.gmatch(output.output, "\n(.+)\n")
    local res = bazel_match()
    if res == nil or res:len()==0 then return end
    res = res:gsub('\n', '')
    if res == nil or res:len()==0 then return end
    local bazel_folder = filedir:gsub(res, '/')..'/...'

    local cmd_str = "!bazel query "..bazel_folder
    local targets = vim.api.nvim_exec2(cmd_str, {output = true}).output
    return targets
end
vim.api.nvim_create_user_command("GetBazelTargets", get_bazel_targets, {})


local function buffer_lines_to_telescope()

    local linebuf = get_bazel_targets()
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
            ordinal = line,  -- Used for sorting and filtering
            display = i .. ": " .. line,  -- What will be displayed in telescope
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
vim.api.nvim_create_user_command('TelescopeBuffer', function()
  buffer_lines_to_telescope()
end, {})

vim.keymap.set("n", "<F8>", buffer_lines_to_telescope)

