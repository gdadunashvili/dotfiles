local function central_float()
    vim.notify("creating central float")


    local buf_id = vim.api.nvim_create_buf(false, true)
    local ui  = vim.api.nvim_list_uis()[1]


    local width = ui.width - 2
    local height = ui.height - 10

    local col = (ui.width/2) - (width/2)
    local row = (ui.height/2) - (height/2)
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
    vim.fn.execute("edit term://zsh")
    return win_id, buf_id
end


vim.keymap.set("n", "<leader>fa", central_float, {} )
