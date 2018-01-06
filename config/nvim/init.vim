" Vim-Plug ---------------------------------------------------------{{{
set nocompatible
" Get vim-plug, if it isn't already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
filetype off
" -------------------------------------------------------------------}}}

" Plugins -----------------------------------------------------------{{{
" Shows a git diff in the gutter (sign column) and stages/reverts hunks
Plug 'airblade/vim-gitgutter'
" Switch segments of text with predefined replacements
Plug 'AndrewRadev/switch.vim'
" Preview colours in source code while editin
Plug 'ap/vim-css-color', { 'for': 'css' }
" A plugin for asynchronous :make
Plug 'benekastah/neomake'
" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Check for attachments when writing mails with mutt
Plug 'chrisbra/CheckAttach', { 'for': 'mail' }
" Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
Plug 'ConradIrwin/vim-bracketed-paste'
"  Using the jedi autocompletion library for VIM.
Plug 'davidhalter/jedi-vim'
" Switching between companion source files (e.g. ".h" and ".cpp")
Plug 'derekwyatt/vim-fswitch'
" Functions and mappings to close open HTML/XML tags
Plug 'docunext/closetag.vim'
" Generate a fast shell prompt with powerline symbols and airline colors
Plug 'edkolev/promptline.vim'
" Edit binary files in a hex mode automatically
Plug 'fidian/hexmode'
" Fantastic selection for VIM
Plug 'gorkunov/smartpairs.vim'
" gitk for Vim
Plug 'gregsexton/gitv'
" A nicer Python indentation style for vim.
Plug 'hynek/vim-python-pep8-indent'
" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs', { 'for': 'tex' }
" Vim support for Julia. http://julialang.org/
Plug 'JuliaLang/julia-vim'
" alignment plugin
Plug 'junegunn/vim-easy-align'
" The missing motion for Vim
Plug 'justinmk/vim-sneak'
" Toggle, display and navigate marks
Plug 'kshenoy/vim-signature'
" A modern vim plugin for editing LaTeX files
Plug 'lervag/vimtex'
" Vim motions on speed!
Plug 'lokaltog/vim-easymotion'
" Display tags in a window, ordered by scope
Plug 'majutsushi/tagbar'
" Highlight columns in csv/tsv/*sv/xsv files in different colors
Plug 'mechatroner/rainbow_csv'
" Flake8 plugin for Vim
Plug 'nvie/vim-flake8', { 'for': 'python' }
" Toggle the mouse focus between Vim and your terminal emulator
Plug 'nvie/vim-togglemouse'
" Syntax file for OpenCL1.1
Plug 'petRUShka/vim-opencl'
" Vim plugin that use clang for completing C/C++ code
Plug 'Rip-Rip/clang_complete'
" Adds font icons (glyphs ★♨☢)
Plug 'ryanoasis/vim-devicons'
"  A tree explorer plugin
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
" Dark powered asynchronous completion framework for neovim
Plug 'Shougo/deoplete.nvim' | Plug 'Shougo/echodoc' | Plug 'zchee/deoplete-jedi'
" Unite and create user interfaces
Plug 'Shougo/unite.vim' | Plug 'Shougo/neoyank.vim' | Plug 'kopischke/unite-spell-suggest'
" Interactive command execution in Vim
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" The ultimate snippet solution for Vim
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Vim undo tree visualizer
Plug 'simnalamburt/vim-mundo'
"  Make scrolling in Vim more pleasant
Plug 'terryma/vim-smooth-scroll'
" Easy text exchange operator for Vim
Plug 'tommcdo/vim-exchange'
" Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" Ghetto HTML/XML mappings
Plug 'tpope/vim-ragtag'
" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'
" An extensible & universal comment plugin that also handles embedded filetypes
Plug 'vim-scripts/tComment'
"Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'
" A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine', { 'for': 'python' }
" Plugins End -------------------------------------------------------}}}

" Colorschemes ------------------------------------------------------{{{
Plug 'endel/vim-github-colorscheme'
Plug 'freeo/vim-kalisi'
Plug 'jacoborus/tender.vim'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'mswift42/vim-themes'
Plug 'nanotech/jellybeans.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'toupeira/vim-desertink'
Plug 'scwood/vim-hybrid'
" Colorschemes END --------------------------------------------------}}}

" Vim-Plug-End ------------------------------------------------------{{{
call plug#end()
" -------------------------------------------------------------------}}}

" Buffer ------------------------------------------------------------{{{
" Switch to last used buffer
nnoremap <tab> :e#<CR>
" Exit normal mode
inoremap jj <Esc>
inoremap jk <Esc>
" Unload buffer
nnoremap <Leader>bd :bd<CR>
" Next buffer
nnoremap <C-n> :bn<CR>
" Previous buffer
nnoremap <C-p> :bp<CR>
" Switch between buffers without saving
set hidden
" -------------------------------------------------------------------}}}

" Case Upper-/Lower -------------------------------------------------{{{
" Make it upercase (motion)
nnoremap gU <esc>mz<esc>gUiw`z
vnoremap gU <esc>mz<esc>gvgU`z
" And make it lowercase.
nnoremap gu <esc>mz<esc>guiw`z
vnoremap gu <esc>mz<esc>gvgu`z
" in input-mode hit ctrl+u to uppercase word
inoremap <c-g> <esc>gUiwea
nnoremap <c-g> gUiw
" -------------------------------------------------------------------}}}

" Clipboard ---------------------------------------------------------{{{
" Have middlemouse on shift-insert at hand
noremap  <S-Insert> <MiddleMouse>
noremap! <S-Insert> <MiddleMouse>
" -------------------------------------------------------------------}}}

" Color -------------------------------------------------------------{{{
set t_Co=256
set background=dark
colorscheme tender
" -------------------------------------------------------------------}}}

" Comments ----------------------------------------------------------{{{
" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" -------------------------------------------------------------------}}}

" F-Keys ------------------------------------------------------------{{{
" F1: Line numbers
inoremap <F1> <C-o>:call NumberToggle()<cr>
nnoremap <F1> :call NumberToggle()<cr>
" F2: Paste-mode
set pastetoggle=<F2>
" F4: Spellchecking
:nnoremap <F4> :setlocal spell! spelllang=en_us<CR>
:inoremap <F4> <ESC>:setlocal spell! spelllang=en_us<CR>a
" F5: Undo tree
nnoremap <F5> :MundoToggle<CR>
inoremap <ESC><F5> :MundoToggle<CR>
" F6: Nerdtree
:imap <F6> <ESC>:NERDTreeToggle<CR>
:map <F6> :NERDTreeToggle<CR>
" F8: Tagbar
nmap <F8> :TagbarToggle<CR>
imap <F8> <ESC>:TagbarToggle<CR>
" -------------------------------------------------------------------}}}

" Fast Terminal -----------------------------------------------------{{{
set ttyfast
" -------------------------------------------------------------------}}}

" Fileypes ----------------------------------------------------------{{{
" C -----------------------------------------------------------------{{{
augroup c_macros
    autocmd!
    autocmd FileType c autocmd FileWritePre    * :call TrimWhiteSpace()
    autocmd FileType c autocmd FileAppendPre   * :call TrimWhiteSpace()
    autocmd FileType c autocmd FilterWritePre  * :call TrimWhiteSpace()
    autocmd FileType c autocmd BufWritePre     * :call TrimWhiteSpace()
augroup END
" -------------------------------------------------------------------}}}

" Django ------------------------------------------------------------{{{
augroup django_python
    au!
    au BufNewFile,BufRead urls.py       setlocal nowrap
    au BufNewFile,BufRead admin.py      setlocal filetype=python.django
    au BufNewFile,BufRead urls.py       setlocal filetype=python.django
    au BufNewFile,BufRead models.py     setlocal filetype=python.django
    au BufNewFile,BufRead views.py      setlocal filetype=python.django
    au BufNewFile,BufRead settings.py   setlocal filetype=python.django
    au BufNewFile,BufRead settings.py   setlocal foldmethod=marker
    au BufNewFile,BufRead forms.py      setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal foldmethod=marker
augroup END
" -------------------------------------------------------------------}}}

" HTML --------------------------------------------------------------{{{
augroup html_macros
    autocmd!
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
    " Use filetype htmldjango in order to have additional django
    " specific syntax highlighting
    au BufNewFile,BufRead *.html setlocal filetype=htmldjango
    au BufNewFile,BufRead *.dram setlocal filetype=htmldjango
augroup END
" -------------------------------------------------------------------}}}

" Latex -------------------------------------------------------------{{{
augroup latex
    autocmd!
    " Compiling manually.
    " Usually I have latexmk -pdf -pvc document.tex running, though
    autocmd FileType tex :nnoremap <F9> :w<CR>:Dispatch rubber --pdf -q %<CR>
    autocmd FileType tex :set spell
augroup END
" -------------------------------------------------------------------}}}

" Make --------------------------------------------------------------{{{
augroup make
    autocmd FileType make setlocal noexpandtab
augroup END
" -------------------------------------------------------------------}}}

" PHP ---------------------------------------------------------------{{{
augroup php_macros
    autocmd!
    autocmd FileType php nmap ^L :!lynx -accept_all_cookies https://php.net/^R^W\#function.^R^W<CR>
    autocmd FileType php let php_sql_query=1
    autocmd FileType php let php_htmlInStrings=1
augroup END
" -------------------------------------------------------------------}}}

" Python ------------------------------------------------------------{{{
augroup python
    autocmd!
    "Flake8 source code checker (F7)
    autocmd FileType python map <buffer> <F10> :call Flake8()<CR>
    "Run python-script by pressing F9
    autocmd FileType python :nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
    "Add : to the end of the last line for python
    autocmd FileType python :inoremap<leader>:  <Esc>k$a:<CR>
    autocmd FileType python :nmap<leader>:  <Esc>k$a:<CR>
    "Removes trailing spaces before writing
    autocmd FileType python autocmd FileWritePre    * :call TrimWhiteSpace()
    autocmd FileType python autocmd FileAppendPre   * :call TrimWhiteSpace()
    autocmd FileType python autocmd FilterWritePre  * :call TrimWhiteSpace()
    autocmd FileType python autocmd BufWritePre     * :call TrimWhiteSpace()
    "Show flake8 errors in gutter
    autocmd FileType python :let g:flake8_show_in_gutter=1
augroup END
" -------------------------------------------------------------------}}}

" VIMRC -------------------------------------------------------------{{{
augroup vimrc
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType vim setlocal foldenable
augroup END
" -------------------------------------------------------------------}}}

" ZSHRC -------------------------------------------------------------{{{
augroup zshrc
    au!
    au FileType zsh setlocal foldmethod=marker
    au FileType zsh setlocal foldenable
augroup END
" -------------------------------------------------------------------}}}
" Filetype End ------------------------------------------------------}}}

" Fold --------------------------------------------------------------{{{
" Don't fold by default. See filetype-section above for i.e. vimrc
" for manually selecting specific filetypes to fold
set nofoldenable
"Jump from fold to fold
"map <Leader>j zj
"map <Leader>k zk
" -------------------------------------------------------------------}}}

" Functions ---------------------------------------------------------{{{
" AppendModline -----------------------------------------------------{{{
" Append modeline after last line in buffer.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
" -------------------------------------------------------------------}}}

" DiffSaved ---------------------------------------------------------{{{
" Compare current buffer with saved file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
" -------------------------------------------------------------------}}}

" NumberToggle ------------------------------------------------------{{{
function! NumberToggle()
    set relativenumber!
    set number!
endfunction
" -------------------------------------------------------------------}}}

" Rename Current File -----------------------------------------------{{{
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
" -------------------------------------------------------------------}}}

" TrimWhiteSpace ----------------------------------------------------{{{
function! TrimWhiteSpace()
        %s/\s\+$//e
endfunction
" -------------------------------------------------------------------}}}
" Functions End -----------------------------------------------------}}}

" Highlighting ------------------------------------------------------{{{
" Enable syntax highlighting
syntax on
" Highlight matching parenthisis as bold
hi MatchParen cterm=bold ctermbg=none ctermfg=none
" -------------------------------------------------------------------}}}

" History -----------------------------------------------------------{{{
set history=1000
" -------------------------------------------------------------------}}}

" Indentation {{{
filetype plugin indent on
" Easier moving of code blocks
vnoremap < <gv
vnoremap > >gv
" -------------------------------------------------------------------}}}

" Insert Mode Completion --------------------------------------------{{{
inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>
inoremap <c-l> <c-x><c-l>
" -------------------------------------------------------------------}}}

" Leader ------------------------------------------------------------{{{
let mapleader="\<SPACE>"
nnoremap <Space> <Nop>
" -------------------------------------------------------------------}}}

" Line Numbers ------------------------------------------------------{{{
" Use relativenumbers to use commands for multiple lines way faster
" For the current line print the absolute linenumber instead of a
" useless 0
set relativenumber
set number
" -------------------------------------------------------------------}}}

" Man Pages ---------------------------------------------------------{{{
" runtime! ftplugin/man.vim " :Man (or Leader-K) to get manpages
" -------------------------------------------------------------------}}}

" Matchit -----------------------------------------------------------{{{
runtime macros/matchit.vim "extends % to e.g if/elsif/else/end
map <Leader><tab> %
" -------------------------------------------------------------------}}}

" Mouse -------------------------------------------------------------{{{
" Enable mouse only in visual mode
setlocal mouse=v
" -------------------------------------------------------------------}}}

" Move Blocks -------------------------------------------------------{{{
nnoremap <Down> :m .+1<CR>==
nnoremap <Up> :m .-2<CR>==
inoremap <Down> <Esc>:m .+1<CR>==gi
inoremap <Up> <Esc>:m .-2<CR>==gi
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
noremap H 0
noremap L $
vnoremap L g_
" -------------------------------------------------------------------}}}

" Move Tabs ---------------------------------------------------------{{{
map <Leader>p <esc>:tabprevious<CR>
map <Leader>n <esc>:tabnext<CR>
map <Leader>c <esc>:tabnew<CR>
" -------------------------------------------------------------------}}}

" Newline -----------------------------------------------------------{{{
" Newline with enter
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
imap <C-j> <Enter>
" -------------------------------------------------------------------}}}

" Open Files --------------------------------------------------------{{{
" map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :spli <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
" -------------------------------------------------------------------}}}

" Paragraph Formatting ----------------------------------------------{{{
vmap Q gq
nmap Q gqap
" -------------------------------------------------------------------}}}

" Plugin Settings ---------------------------------------------------{{{

" Airline -----------------------------------------------------------{{{
set laststatus=2 " allways enable the powerline
set noshowmode " " hide mode, since we are using airline for that
" Show a line on top with all open tabs. If there are none, list all
" open buffers
let g:airline#extensions#tabline#enabled = 2
" Don't display the buffer-line, if there's only the current one open
let g:airline#extensions#tabline#buffer_min_count = 2
" Disable the close button
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_powerline_fonts = 1 " use powerline font symbols
" Get rid of the unnecessary symbol after the max line-nr
let g:airline_symbols = get(g:,'airline_symbols',{})
let g:airline_symbols.maxlinenr=''
let g:airline_theme = 'jellybeans'
" let g:airline_theme = 'papercolor'
" -------------------------------------------------------------------}}}

" CheckAttach -------------------------------------------------------{{{
" Check mail for the following words
let g:attach_check_keywords = 'angehängt, Anhang, anhang, attached, attachment'
" Use ranger to attach file
let g:checkattach_filebrowser = 'ranger'
" -------------------------------------------------------------------}}}

" Closetag ----------------------------------------------------------{{{
let g:closetag_filenames = "*.html,*.xhtml,*.phtml, *.php, *.htm"
" -------------------------------------------------------------------}}}

" Deoplete ----------------------------------------------------------{{{
let g:deoplete#enable_at_startup = 1
let g:echodoc_enable_at_startup = 1
" close preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" C/C++ autocompletion
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_use_library = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#std#c = 'c11'
" Python autocompletion
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0
" let g:deoplete#sources#jedi#show_docstring = 1
" -------------------------------------------------------------------}}}

" Easymotion --------------------------------------------------------{{{
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
" map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" keep cursor colum when JK motion
let g:EasyMotion_startofline = 0
" exclude ';' for non-us-layout
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
" -------------------------------------------------------------------}}}

" Fugitive ----------------------------------------------------------{{{
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
" -------------------------------------------------------------------}}}

" Gitv --------------------------------------------------------------{{{
nnoremap <leader>gv :Gitv<cr>
" -------------------------------------------------------------------}}}

" Neomake -----------------------------------------------------------{{{
autocmd! BufWritePost * Neomake
" -------------------------------------------------------------------}}}

"NERDTree -----------------------------------------------------------{{{
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
" -------------------------------------------------------------------}}}

" Promptline --------------------------------------------------------{{{
let g:promptline_theme = 'airline'
let g:promptline_preset = {
    \'b': [ promptline#slices#host(), promptline#slices#user() ],
    \'c': [ promptline#slices#cwd() ],
    \'warn': [ promptline#slices#battery({ 'threshold': 10})],
    \'y': [ promptline#slices#git_status() ],
    \'z': [ promptline#slices#vcs_branch() ]}
" -------------------------------------------------------------------}}}

" Smooth Scrolling --------------------------------------------------{{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 2)<CR>
" -------------------------------------------------------------------}}}

" Switch ------------------------------------------------------------{{{
" switch-plugin: toggle with -
nnoremap - :Switch<CR>
" -------------------------------------------------------------------}}}
" Targets -----------------------------------------------------------{{{
" Preserve whitespaces by default
nmap cia cIa
" -------------------------------------------------------------------}}}

" Ultisnips ---------------------------------------------------------{{{
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-r>"
let g:UltiSnipsListSnippets        = "<c-b>"
" -------------------------------------------------------------------}}}

" Unite -------------------------------------------------------------{{{
" let g:unite_source_history_yank_enable = 1
" nnoremap <leader>y :Unite history/yank<cr>
" nnoremap <leader>b :Unite -quick-match buffer<cr>
" nnoremap <leader>u<space> :Unite grep:.<cr>
" nnoremap <C-p> :Unite file_rec/async<cr>
let g:unite_source_history_yank_enable = 1
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer buffer<cr>
nnoremap <silent> z= <Esc>:Unite -buffer-name=spell -auto-resize spell_suggest<CR>
" -------------------------------------------------------------------}}}

" vim-easy-align ----------------------------------------------------{{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" -------------------------------------------------------------------}}}
" Plugins End -------------------------------------------------------}}}

" Quit --------------------------------------------------------------{{{
noremap <Leader>q :quit<CR>
" -------------------------------------------------------------------}}}

" Reload ------------------------------------------------------------{{{
" Automatically reload files changed outside of vim
set autoread

" Auto-reload vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
" -------------------------------------------------------------------}}}

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

" Scrolling ---------------------------------------------------------{{{
set scrolloff=8         "Start scrolling before reaching the end
set sidescrolloff=15
set sidescroll=1
" -------------------------------------------------------------------}}}

" Search ------------------------------------------------------------{{{
set ignorecase
set smartcase
set hlsearch
" Clear search highlights
noremap <silent><Leader>/ :nohls<CR>
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" -------------------------------------------------------------------}}}

" Splits ------------------------------------------------------------{{{
" Open to right and bottom
set splitbelow
set splitright
" Resize, width, heigt or normalize
map ctrl + w _
map ctrl + w |
map ctrl + w =
" Move around
" map <c-j> <c-w>j
" map <c-k> <c-w>k
" map <c-l> <c-w>l
" map <c-h> <c-w>h
" Resize splits when window is resized
au VimResized * :wincmd =
" Easier
noremap <leader>v <C-w>v
" -------------------------------------------------------------------}}}

" Swap --------------------------------------------------------------{{{
" Save all swap-files in the same place
if isdirectory($HOME . '/.config/nvim/tmp') == 0
  :silent !mkdir -p ~/.config/nvim/tmp >/dev/null 2>&1
endif
set swapfile
set dir=~/.config/nvim/tmp
" -------------------------------------------------------------------}}}

" Tab ---------------------------------------------------------------{{{
" Use 4 spaces instead of a tab.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
" -------------------------------------------------------------------}}}

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

" Undo --------------------------------------------------------------{{{
set undofile
set undodir=~/.config/nvim/tmp
set undoreload=10000
set undolevels=10000
" Remap U to <C-r> for easier redo
nnoremap U <C-r>
" -------------------------------------------------------------------}}}

" Wrap Line ---------------------------------------------------------{{{
set tw=80	    " width of document (used by gd)
" set nowrap	" don't automatically wrap on load
set fo-=t	    " don't automatically wrap text when typing
" set colorcolumn=80
:set showbreak=↳\ \ \
" -------------------------------------------------------------------}}}
