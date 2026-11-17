vim.keymap.set("n", "<leader>u", function() vim.cmd(":Atone toggle") end)
return {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    -- ---@module "atone"
    -- ---@type AtoneConfig
    opts = {},
}
