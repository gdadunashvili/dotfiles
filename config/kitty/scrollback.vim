" set leader to space
let mapleader = " "

set clipboard^=unnamedplus
set signcolumn=no
set nolist
set laststatus=0
set scrolloff=0
set nowrapscan
set noma

xnoremap <buffer> <cr> "+y
nnoremap <buffer> <leader>q <cmd>q!<cr>
nnoremap <buffer> H H
nnoremap <buffer> L L

"move cursor to the last edited line
call cursor(line('$'), 0)
silent! call search('\S', 'b')
silent! call search('\n*\%$')
call cursor(0, 1)
execute "normal! \<c-y>"
