return {
    "bazelbuild/vim-bazel",
    dependencies = {
        "google/vim-maktaba",
    },
    build=function ()
        vim.cmd(':PlugInstall')
    end,

}
