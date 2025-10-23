return {
    "danymat/neogen",
    config = function()
        local i = require("neogen.types.template").item
        require('neogen').setup({
            snippet_engine = "nvim",
            input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation

            languages = {
                cpp = {
                    template = {
                        -- Which annotation convention to use
                        annotation_convention = "doxygen",
                        doxygen = {
                            { nil,         "/// \\file",        { no_results = true, type = { "file" } } },
                            { nil,         "/// \\brief $1",    { no_results = true, type = { "func", "file", "class" } } },
                            { nil,         "",                  { no_results = true, type = { "file" } } },

                            { i.ClassName, "/// \\class %s",    { type = { "class" } } },
                            { i.Type,      "/// \\typedef %s",  { type = { "type" } } },
                            { nil,         "/// \\brief $1",    { type = { "func", "class", "type" } } },

                            { i.Tparam,    "/// \\tparam %s $1" },
                            { i.Parameter, "/// \\param %s $1" },
                            { i.Return,    "/// \\return $1" },
                        }
                    }
                }
            }
        })
    end
}
