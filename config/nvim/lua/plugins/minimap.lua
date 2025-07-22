-- local function update_variable()
--     print("resizing")
--     if  vim.g.neominimap == nil then
--         print("not gonna resize nothin")
--         return
--     -- require("neominimap").setup()
--     end
--     print("gonna resize somethin")
--
--     local width = vim.api.nvim_win_get_width(0)
--     local min_width = vim.g.neominimap.float.minimap_witdth
--     if width > 120 + min_width  then
--         
--         print(width)
--     end
-- end

-- vim.api.nvim_create_autocmd("VimResized", {
--     callback = update_variable,
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = update_variable,
-- })
--
--
return {

    'Isrothy/neominimap.nvim',

    init = function ()
        vim.g.neominimap = {
            auto_enable = false,
            x_multiplier = 1,
            y_multiplier = 1,
            layout = "float",
            float = {
                minimap_witdth = 120,
            },
            delay = 100,
            mark = {
                enabled = true,
              },

              mini_diff = {
                  enabled = true,
              },

              treesitter = {
                  enabled = true,
                  priority = 200,
              },

              search = {
                  enabled = true,
              },
          }
    end
}
