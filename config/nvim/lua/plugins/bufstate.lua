return {
    "syntaxpresso/bufstate.nvim",
    dependencies = { "folke/snacks.nvim" }, -- optional, for nicer UI
    opts = {
        -- LSP management
        stop_lsp_on_tab_leave = true,    -- Stop LSP when leaving a tab
        stop_lsp_on_session_load = true, -- Stop all LSP before loading a session
        autoload_last_session = true,    -- Auto-load last session on startup

        -- Autosave
        autosave = {
            enabled = true,    -- Enable periodic background saves
            on_exit = true,    -- Save when exiting Neovim
            interval = 100000, -- 5 minutes (in ms, 0 = disabled)
            debounce = 30000,  -- Minimum 30 seconds between saves
        },
    },

    -- Override default keymaps (uncomment to use)
    -- keys = {
    --   { "<leader>qs", "<cmd>BufstateSave<CR>",   desc = "Save session" },
    --   { "<leader>qS", "<cmd>BufstateSaveAs<CR>", desc = "Save session as" },
    --   { "<leader>ql", "<cmd>BufstateLoad<CR>",   desc = "Load session" },
    --   { "<leader>qd", "<cmd>BufstateDelete<CR>", desc = "Delete session" },
    --   { "<leader>qn", "<cmd>BufstateNew<CR>",    desc = "New session" },
    --   { "<leader>qc", "<cmd>BufstateClose<CR>", desc = "Close workspace" },
    --   { "<leader>qa", "<cmd>BufstateAlternate<CR>", desc = "Alternate session" },
    -- },
}

-- Bufferline integration (uncomment to use):
-- require("bufferline").setup({
--   options = {
--     always_show_bufferline = true,
--     custom_filter = require("bufstate").buf_filter,
--     close_command = function(buf)
--       require("bufstate").bdelete(buf)
--     end,
--   },
-- })
