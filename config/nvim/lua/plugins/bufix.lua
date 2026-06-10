return {
    "msaher/bufix.nvim",
    config = function()
        local group = vim.api.nvim_create_augroup("BufixTerm", { clear = true })
        vim.api.nvim_create_autocmd("TermOpen", {
            group = group,
            callback = function(opts)
                require("bufix.api").register_buf(opts.buf) -- make it work with goto_next() and friends
            end,
        })


        require("bufix").setup({
            rules = {
                -- rust0 = [[%*[^\ ] %f:%l:%c]],
                rust = [[%s %f:%l:%c]],
            }
        })
    end
}
