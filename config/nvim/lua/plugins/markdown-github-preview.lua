return {
    "wallpants/github-preview.nvim",
    cmd = { "GithubPreviewToggle" },
    keys = { "<leader>mpt" },
    ---@type github_preview_config
    opts = {
        -- config goes here
    },
    config = function(_, opts)
        local gpreview = require("github-preview")
        gpreview.setup(opts)

        local fns = gpreview.fns
        vim.keymap.set("n", "<leader>gmt", fns.toggle)
        vim.keymap.set("n", "<leader>gms", fns.single_file_toggle)
        vim.keymap.set("n", "<leader>gmd", fns.details_tags_toggle)
    end,
}
