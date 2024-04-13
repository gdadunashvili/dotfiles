
vim.keymap.set('n', '<leader>hl', ':Dasht ', {})
vim.keymap.set('n', '<leader>h!', ':Dasht! ', {})

vim.keymap.set('n', '<leader>hcl', ':call Dasht(dasht#cursor_search_terms())<Return>', {})
vim.keymap.set('n', '<leader>hc!', ':call Dasht(dasht#cursor_search_terms(), "!")<Return>', {})

vim.keymap.set('v', '<leader>hl', 'y:<C-U>call Dasht(getreg(0))<Return>', {})
vim.keymap.set('v', '<leader>h!', 'y:<C-U>call Dasht(getreg(0), "!")<Return>', {})
