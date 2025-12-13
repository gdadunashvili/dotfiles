local plugin_lib = {}
function plugin_lib.central_float()
    local buf_id = vim.api.nvim_create_buf(false, true)
    local ui     = vim.api.nvim_list_uis()[1]


    local width = ui.width - 2
    local height = ui.height - 10

    local col = (ui.width / 2) - (width / 2)
    local row = (ui.height / 2) - (height / 2)
    --- @type vim.api.keyset.win_config
    local opts = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        anchor = 'NW',
        mouse = true,

    }

    local win_id = vim.api.nvim_open_win(buf_id, true, opts)
    return win_id, buf_id
end

--- @param str string
--- @param sep string
---@return fun():string, ...
function plugin_lib.split_str(str, sep)
    return string.gmatch(str, "([^" .. sep .. "]+)")
end

--- @param str string
--- @return fun():string, ...
function plugin_lib.linewise(str)
    return plugin_lib.split_str(str, '\n')
end

--- Split a sentence on space separators
---@param line string
---@return string[]
function plugin_lib.split_to_words(line)
    local split_on_space_iterator = line:gmatch('(%S+)') -- match everything that is not a space charachter
    local words                   = {}
    for word in split_on_space_iterator do
        table.insert(words, word)
    end
    return words
end

--- @param word string
function plugin_lib.make_into_destination_if_possible(word)
    local match_it              = word:gmatch('([%w_%-%.]*/[^:]*):(%d+):(%d+):')
    local path, line_nr, col_nr = match_it()
    if path ~= nil and path:len() > 0 then
        return path, line_nr, col_nr
    end
end

--- @param buffer_nr integer
--- @param line_nr integer
--- @param char string
function plugin_lib.put_char_in_gutter(buffer_nr, line_nr, char)
    local hlg = 'comment'
    local sign_name = 'bla'
    local sign_group = 'bla_group'
    local namespace_id = vim.api.nvim_create_namespace("bla");
    vim.fn.sign_define(sign_name, {
        text = char,
        texthl = hlg,
    })



    local buf_name = vim.fn.expand('%')
    vim.fn.sign_place(0, sign_group, sign_name, buf_name, { lnum = line_nr + 1, priority = 90 })
    vim.api.nvim_buf_set_extmark(buffer_nr, namespace_id, line_nr, -1, {
        virt_text = { { 'bla', hlg } },
        -- vim.api.nvim_buf_get_extmarks
        virt_text_pos = 'inline'
    })
end

--- Helper function for creating macros and binding them to key combos.
---@param mode string[]
---@param keymap string
---@param expansion string[]
---@param as_comment bool
function plugin_lib.insert_macro(mode, keymap, expansion, as_comment)
    local insert = function()
        local coordinates = vim.api.nvim_win_get_cursor(0)
        local row = coordinates[1]
        if as_comment == true then
            vim.cmd("norm gcc")
        end
        vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, 0, expansion)
    end
    vim.keymap.set(mode, keymap, insert, {})
end

return plugin_lib
