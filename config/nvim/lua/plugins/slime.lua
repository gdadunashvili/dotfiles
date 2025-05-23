return {
    'jpalardy/vim-slime',

    init = function()
        vim.g.slime_no_mappings = 1
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_cell_delimiter = '#%%'
        vim.g.slime_target = "tmux"
        vim.g.slime_default_config = {socket_name = "default", target_pane = "2"}

    end,
    config = function ()
        vim.keymap.set("x", "<leader>ss", '<Plug>SlimeRegionSend', opts)
        vim.keymap.set("n", "<leader>sl", '<Plug>SlimeLineSend', opts)
        vim.keymap.set("n", "<leader>sc", '<Plug>SlimeSendCell', opts)
        vim.keymap.set("n", "<leader>sd", function () vim.api.nvim_put({'#%%'} , 'l', true, true) end, opts)
    end
}
