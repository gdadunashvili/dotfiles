vim.filetype.add({
    extension = {
        pest = "pest",
    },
})

-- when pest buffer attaches set local commentstring to "// %s"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "pest",
    callback = function(args)
        vim.bo[args.buf].commentstring = "// %s"
    end,
})
