--------------------------------------------------------------------------------
--------------------------------- Markdown -------------------------------------
--------------------------------------------------------------------------------


---@param inset_inline boolean
local insert_bulletpoint = function(inset_inline)
    local stubs = { '- [ ] ' }

    local coordinates = vim.api.nvim_win_get_cursor(0)
    local row = coordinates[1]
    local col = coordinates[2]
    vim.cmd('norm o')
    if inset_inline then
        vim.api.nvim_buf_set_text(0, row - 1, col, row, col, stubs)
    else
        vim.api.nvim_buf_set_text(0, row, 0, row, 0, stubs)
    end
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
