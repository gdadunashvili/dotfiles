return {
  'bkad/CamelCaseMotion',
  config = function()
      -- vim.cmd("let g:camelcasemotion_key = '<leader>'")
      -- vim.g.camelcasemotion_key ='<leader>'
      vim.keymap.set('o', 'iw', '<Plug>CamelCaseMotion_iw', { silent = true })
      vim.keymap.set({'n', 'v'}, 'w', '<Plug>CamelCaseMotion_w', { silent = true })
      vim.keymap.set({'n', 'v'}, 'b', '<Plug>CamelCaseMotion_b', { silent = true })
      vim.keymap.set({'n', 'v'}, 'e', '<Plug>CamelCaseMotion_e', { silent = true })
      vim.keymap.set({'n', 'v'}, 'ge', '<Plug>CamelCaseMotion_ge', { silent = true })
  end,
}
