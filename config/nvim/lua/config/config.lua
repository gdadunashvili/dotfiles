vim.opt.cursorline = true

-- Create an autocommand group
vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd({"BufWritePre"},
{
    group = "FormatOnSave",
    pattern = { "*.cpp", "*.h", "*.hpp" },
    callback= function ()
        vim.cmd("%!clang-format")
        vim.notify("formatting with clang-format", "info")
    end
})


