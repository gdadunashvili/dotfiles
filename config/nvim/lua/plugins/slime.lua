local initialize_slime_split = function()
    local cwd = vim.fn.getcwd()
    local command = "!kitty @ launch --cwd=" .. cwd .. " ipython  --TerminalInteractiveShell.editing_mode=vi"
    vim.notify(command)
    vim.api.nvim_command(command)
end

return {
    'jpalardy/vim-slime',

    config = function()
        vim.g.slime_no_mappings = 1
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_cell_delimiter = '# %%'
        vim.g.slime_target = "kitty"
        -- vim.g.slime_default_config = {
        --     socket_name = "default",
        --     target_pane = "2",
        --     listen_on = "unix:/tmp/mykitty"
        -- }

        -- vim.g.slime_python_ipython = 1
        vim.g.slime_bracketed_paste = 1

        vim.keymap.set('n', '<leader>si', initialize_slime_split, opts)
        vim.keymap.set("x", "<leader>ss", '<Plug>SlimeRegionSend', opts)
        vim.keymap.set("n", "<leader>sl", '<Plug>SlimeLineSend', opts)
        vim.keymap.set("n", "<leader>sc", '<Plug>SlimeSendCell', opts)
        vim.keymap.set("n", "<leader>sd", function() vim.api.nvim_put({ '#%%' }, 'l', true, true) end, opts)
    end
}
