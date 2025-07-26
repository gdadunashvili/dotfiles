return {
  'vim-scripts/TComment',
  config = function()
    vim.keymap.set('n', '<leader>/', ':TComment<CR>j')
    vim.keymap.set('i', '<C-/>', '<esc>:TComment<CR>j')

    vim.keymap.set('x', '<leader>/', function()
      if vim.fn.mode() == 'V' then
        return ':TCommentBlock<CR>'
      else
        return ':TCommentInline<CR>'
      end
    end, { expr = true })
  end,
}
