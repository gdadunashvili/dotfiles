vim.filetype.add({
    extension = {
        trlc = "trlc",
    },
})


-- AI generated *.trlc buffer higlighting which works pretty well
-- Inline TRLC syntax highlighting on entering a *.trlc buffer (single vim.cmd block)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*.trlc",
    callback = function(ev)
        vim.bo[ev.buf].filetype = "trlc"
        vim.cmd([[set formatoptions-=t]])
        vim.cmd([[
      syntax enable

      " Clear our syntax groups (avoid duplicates when re-entering)
      silent! syntax clear trlcKeyword
      silent! syntax clear trlcIdentifier
      silent! syntax clear trlcInteger
      silent! syntax clear trlcDecimal
      silent! syntax clear trlcString
      silent! syntax clear trlcTripleString
      silent! syntax clear trlcOperator
      silent! syntax clear trlcBooleanOp
      silent! syntax clear trlcPunct
      silent! syntax clear trlcDelimiter

      " Keywords (reserved words)
      syntax keyword trlcKeyword
            \ abs abstract and checks else elsif enum error exists extends false fatal final
            \ forall freeze if implies import in not null optional or package section separator
            \ then true tuple type warning xor

      " Identifiers: [a-zA-Z][a-zA-Z0-9_]*
      syntax match trlcIdentifier "\v<[A-Za-z][A-Za-z0-9_]*>"

      " Integers:
      "   (0[xb])?[0-9a-fA-F]+(_[0-9a-fA-F]+)*
      " Highlighting does not enforce base-valid digits; it just colors the token.
      syntax match trlcInteger "\v<(0[xX][0-9A-Fa-f]+(_[0-9A-Fa-f]+)*|0[bB][01]+(_[01]+)*|[0-9]+(_[0-9]+)*)>"

      " Decimals:
      "   [0-9]+(_[0-9]+)*\.[0-9]+(_[0-9]+)*
      syntax match trlcDecimal "\v<\d+(_\d+)*\.\d+(_\d+)*>"

      " Strings
      " Double-quoted (no newlines), supports \" escape
      syntax region trlcString start=+"+ skip=+\\\"+ end=+"+ keepend oneline

      " Triple-quoted strings (multiline, no escapes)
      syntax region trlcTripleString start=+'''+ end=+'''+ keepend
      syntax region trlcTripleString start=+"""+ end=+"""+ keepend

      " Operators / punctuation / delimiters
      " Prefer longer tokens first
      syntax match trlcOperator  "\V**"
      syntax match trlcBooleanOp "\V==\|<=\|>=\|!="
      syntax match trlcPunct     "\V=>\|.."

      syntax match trlcOperator  "[*/%+\-]"
      syntax match trlcBooleanOp "[<>]"
      syntax match trlcPunct     "[,\.=]"
      syntax match trlcDelimiter "[@:;]"
      syntax match trlcDelimiter "[()\[\]{}]"

      " Highlight links
      highlight default link trlcKeyword Keyword
      highlight default link trlcIdentifier Identifier

      highlight default link trlcInteger Number
      highlight default link trlcDecimal Float

      highlight default link trlcString String
      highlight default link trlcTripleString String

      highlight default link trlcOperator Operator
      highlight default link trlcBooleanOp Operator
      highlight default link trlcPunct Delimiter
      highlight default link trlcDelimiter Delimiter
    ]])
    end,
})


-- Define the client configuration

local trlc_cfg = {
    name = "trlc-lsp",
    cmd = { "trlc-lsp" },
    root_markers = { ".git" },
    filetypes = { "trlc", "rsl" },
    settings = {
        trlcServer = {
            parsing = 'full',
            verify = true,
        },
    }
}

vim.lsp.config["trlc-lsp"] = trlc_cfg
vim.lsp.enable("trlc-lsp")
