return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    lazy = false,

    build = function()
        vim.cmd(':TSUpdate')
    end,

    config = function()
        vim.opt.runtimepath:append("$HOME/.local/share/treesitter")
        require('nvim-treesitter').install { "c", "cpp", "lua", "python", "vim", "vimdoc", "query", "markdown", "doxygen" }

        require 'treesitter-context'.setup {}


        vim.keymap.set({ "x", "o" }, "if", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end)

        vim.keymap.set({ "x", "o" }, "af", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end)
    end
}
