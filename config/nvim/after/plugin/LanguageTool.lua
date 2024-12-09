vim.cmd [[
let  g:grammarous#jar_url = 'https://www.languagetool.org/download/LanguageTool-5.9.zip' 
" let g:grammarous#languagetool_cmd = 'languagetool'

let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
let g:grammarous#enabled_rules = {'*' : ['PASSIVE_VOICE']}

let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><CR> <Plug>(grammarous-fixit) <Plug>(grammarous-move-to-next-error)
    nmap <buffer><leader><CR> <Plug>(grammarous-fixall)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nunmap <buffer><CR>
    nunmap <buffer><leader><CR>
endfunction

]]

vim.keymap.set("n", "<leader>s", function() vim.cmd("GrammarousCheck --lang=en-US") end)
