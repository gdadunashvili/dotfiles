vim.cmd [[
" Switch to last used buffer
"nnoremap <tab> :e#<CR>
" Exit normal mode
"inoremap jj <Esc>
"inoremap jk <Esc>
" Unload buffer


" Move Blocks -------------------------------------------------------{{{
"nnoremap <Down> :m .+1<CR>==
"nnoremap <Up> :m .-2<CR>==
"inoremap <s-Down> <Esc>:m .+1<CR>==gi
"inoremap <s-Up> <Esc>:m .-2<CR>==gi
"vnoremap <Down> :m '>+1<CR>gv=gv
"vnoremap <Up> :m '<-2<CR>gv=gv
" -------------------------------------------------------------------}}}

" Move Tabs ---------------------------------------------------------{{{
"map <Leader>p <esc>:tabprevious<CR>
"map <Leader>n <esc>:tabnext<CR>
"map <Leader>c <esc>:tabnew<CR>
" -------------------------------------------------------------------}}}

" Save --------------------------------------------------------------{{{
" Save the file with ctrl+s needs terminal alias or it will freeze
" according to the default behaviour of ctrl+s / ctrl+q in a terminal
" alias nvim="stty stop '' -ixoff ; nvim"
"noremap  <C-S> :update<CR>
"vnoremap <C-S> <C-C>:update<CR>
"inoremap <C-S> <C-O>:update<CR><Esc>

" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %
" -------------------------------------------------------------------}}}

" Search ------------------------------------------------------------{{{
set ignorecase
set smartcase
set hlsearch

nnoremap n nzzzv
nnoremap N Nzzzv
" -------------------------------------------------------------------}}}

" Splits ------------------------------------------------------------{{{
" Open to right and bottom
set splitbelow
set splitright
" Resize, width, heigt or normalize


" Tab Completion ----------------------------------------------------{{{
" Make tab completion for files/buffers act like bash
set wildmode=full
set wildmenu
" -------------------------------------------------------------------}}}

" Timeout -----------------------------------------------------------{{{
set notimeout
set ttimeout
set timeoutlen=10
" -------------------------------------------------------------------}}}

" Insert Mode -------------------------------------------------------{{{
imap <c-del> <esc>d e
imap <c-y> <esc>dd i
inoremap <c-cr> <esc>o
imap <c-d> <esc>yy p i
" -------------------------------------------------------------------}}}


]]
