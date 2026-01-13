local lpeg = vim.lpeg
local P, R, S, V = lpeg.P, lpeg.R, lpeg.S, lpeg.V
local C, Cg, Ct, Cc, Cp = lpeg.C, lpeg.Cg, lpeg.Ct, lpeg.Cc, lpeg.Cp

local function except(set)
    return 1 - S(set)
end

local function Cg_span(patt, name)
    return Cg(
        Ct(
            Cp() * -- start position
            Cg(patt, "value") *
            Cp()   -- end
        ) / function(t)
            return { start = t[1], value = t.value, finish = t[2] }
        end,
        name
    )
end

-- Helper patterns
local blank = S(" \t") ^ 0
local blanks = S(" \t") ^ 1
local digit = R("09")
local digits = digit ^ 1
local any = P(1)
local eol = P("\n")
local rest_of_line = (1 - eol) ^ 0
local file_char = 1 - S(",:\n\t()\"' ][)(=")
local filename = file_char ^ 1
local dquote = P '"'
-- P(":") *
local win_or_unix_filename = (C(R("AZ", "az") * filename, "filename") + C(filename, "filename") + C((P("/") + P("~/")) * filename, "filename"))


return {
    "msaher/bufix.nvim",
    config = function()
        require("bufix").setup({
            rules = {
                paths = Ct(any * (blanks + P("//") + P("~")) * Cg_span(win_or_unix_filename, "filename") *
                    Cg_span(Cc "I", "type"))
            }
        })

        local group = vim.api.nvim_create_augroup("BufixTerm", { clear = true })
        vim.api.nvim_create_autocmd("TermOpen", {
            group = group,
            callback = function(opts)
                require("bufix.api").register_buf(opts.buf) -- make it work with goto_next() and friends
            end,
        })
    end
}
