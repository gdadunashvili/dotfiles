return {
  'bkad/CamelCaseMotion',
  config = function()
    vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', { silent = true })
    vim.keymap.set('', 'iw', '<Plug>CamelCaseMotion_iw', { silent = true })
    vim.keymap.set('', 'b', '<Plug>CamelCaseMotion_b', { silent = true })
    vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', { silent = true })
    vim.keymap.set('', 'ge', '<Plug>CamelCaseMotion_ge', { silent = true })
  end,
}
