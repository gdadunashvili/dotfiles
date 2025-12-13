--------------------------------------------------------------------------------
--------------------------------- Markdown -------------------------------------
--------------------------------------------------------------------------------


local insert_bulletpoint = function()
    local stubs = { '- [ ] ' }

    local coordinates = vim.api.nvim_win_get_cursor(0)
    local row = coordinates[1]
    vim.cmd('norm o')
    vim.api.nvim_buf_set_text(0, row, 0, row, 0, stubs)
    vim.cmd('norm A')
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("MarkdownLocalFunctionality", { clear = false }),
    pattern = { "*.md" },
    callback = function()
        vim.keymap.set("n", "<localleader>o", insert_bulletpoint,
            { noremap = true, silent = true })
    end
})
