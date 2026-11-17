return {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    ---@module "atone"
    ---@type AtoneConfig
    opts = {},
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}
