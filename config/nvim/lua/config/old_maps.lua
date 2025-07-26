vim.cmd [[
" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %
" ----------------------------------

" Search 
set ignorecase
set smartcase
set hlsearch
" ----------------------------------

nnoremap n nzzzv
nnoremap N Nzzzv
" ----------------------------------

" Splits 
" Open to right and bottom
set splitbelow
set splitright
" ----------------------------------

]]
