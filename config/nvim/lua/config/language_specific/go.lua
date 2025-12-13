local function make_err_stub()
    local stubs = { 'if err != nil { return err; }' }

    local coordinates = vim.api.nvim_win_get_cursor(0)
    local row = coordinates[1]
    vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, 0, stubs)
end
vim.api.nvim_create_augroup("GoLocalLeaderMappings", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("CppLocalFunctionality", { clear = false }),
    pattern = { "*.go" },
    callback = function()
        vim.api.nvim_create_user_command("InsertErrStupStub", make_err_stub, {})
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>e", "<cmd>InsertErrStupStub<CR>",
            { noremap = true, silent = true })
    end
})
