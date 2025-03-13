return {
    'braxtons12/blame_line.nvim',
    config = function()

        require("blame_line").setup {
            show_in_visual = true,
            show_in_insert = true,
            prefix = " ",
            -- `"<author>"` - the author of the change.
            -- `"<author-mail>"` - the email of the author.
            -- `"<author-time>"` - the time the author made the change.
            -- `"<committer>"` - the person who committed the change to the repository.
            -- `"<committer-mail>"` - the email of the committer.
            -- `"<committer-time>"` - the time the change was committed to the repository.
            -- `"<summary>"` - the commit summary/message.
            -- `"<commit-short>"` - short portion of the commit hash.
            -- `"<commit-long>"` - the full commit hash.
            template = "<author> <author-time> • <summary> • <commit-short> <author-mail>",
            date = {
                relative = true,
                format = "%d-%m-%y %H:%M",
            },
            hl_group = "BlameLineNvim",
            delay = 400,
        }
    end
  }
