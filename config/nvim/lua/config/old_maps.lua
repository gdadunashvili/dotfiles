vim.cmd [[
" Switch to last used buffer
nnoremap <tab> :e#<CR>
" Exit normal mode
inoremap jj <Esc>
inoremap jk <Esc>
" Unload buffer
nnoremap <Leader>bd :bd<CR>

" Leader ------------------------------------------------------------{{{
" let mapleader="<SPACE>"
" nnoremap <Space> <Nop>
" -------------------------------------------------------------------}}}

" Line Numbers ------------------------------------------------------{{{
" Use relativenumbers to use commands for multiple lines way faster
" For the current line print the absolute linenumber instead of a
" useless 0
set relativenumber
set number
" -------------------------------------------------------------------}}}

" Move Blocks -------------------------------------------------------{{{
nnoremap <Down> :m .+1<CR>==
nnoremap <Up> :m .-2<CR>==
inoremap <s-Down> <Esc>:m .+1<CR>==gi
inoremap <s-Up> <Esc>:m .-2<CR>==gi
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv
" -------------------------------------------------------------------}}}

" Move Lines --------------------------------------------------------{{{
" Move rows instead of lines for wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" More often I have to address the beginning or end of a line instead
" of the currently displayed text. But the jumps would be too unprecise
" in most cases anyway.
" noremap H _
" noremap L $
" vnoremap L g_
" -------------------------------------------------------------------}}}

" Move Tabs ---------------------------------------------------------{{{
map <Leader>p <esc>:tabprevious<CR>
map <Leader>n <esc>:tabnext<CR>
map <Leader>c <esc>:tabnew<CR>
" -------------------------------------------------------------------}}}

" Newline -----------------------------------------------------------{{{
" Newline with enter
nmap <S-Enter> O<Esc>
" nmap <CR> o<Esc>
"imap <C-j> <Enter>
" -------------------------------------------------------------------}}}

" Open Files --------------------------------------------------------{{{
" map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :spli <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
" -------------------------------------------------------------------}}}
noremap <Leader>q :quit<CR>
" -------------------------------------------------------------------}}}

" Reload ------------------------------------------------------------{{{
" Automatically reload files changed outside of vim
set autoread

" Save --------------------------------------------------------------{{{
" Save the file with ctrl+s needs terminal alias or it will freeze
" according to the default behaviour of ctrl+s / ctrl+q in a terminal
" alias nvim="stty stop '' -ixoff ; nvim"
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR><Esc>

" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %
" -------------------------------------------------------------------}}}

" Search ------------------------------------------------------------{{{
set ignorecase
set smartcase
set hlsearch
" Clear search highlights
" noremap <silent><Leader>/ :nohls<CR>
" Keep search matches in the middle of the window.
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
