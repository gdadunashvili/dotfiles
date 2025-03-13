return {
	  'nvim-telescope/telescope.nvim',
	  dependencies = {'nvim-lua/plenary.nvim'},
      config =  function ()
          require('telescope').setup({
              defaults = {
                  layout_strategy = 'flex',
                  layout_config = {
                      width = 0.99,
                      height = 0.98,
                      horizontal = {
                          mirror = false,
                          preview_width = 0.6,  -- Preview width as a percentage of the Telescope window width
                      },
                  }
              }
          })
          local builtin = require('telescope.builtin')

          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>gg', builtin.git_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
          vim.keymap.set('n', '<leader>fp', function ()
              builtin.grep_string({
                  search = vim.fn.input("Grep > ")});
              end)
      end
}
