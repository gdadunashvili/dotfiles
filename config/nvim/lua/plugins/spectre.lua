return {
    'nvim-pack/nvim-spectre',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
        require('spectre').setup()

        vim.keymap.set('n', '<leader>s', '<cmd>lua require("spectre").toggle()<CR>')
    end
}
