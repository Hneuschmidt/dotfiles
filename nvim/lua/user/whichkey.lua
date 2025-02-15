local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
    print("whichkey not okay")
    return
end

whichkey.setup({
    opts = {
        plugins = {
            spelling = {
                enabled = true,
                suggestions = 20,
            }
        },
    },
    delay=400
})

whichkey.add({
    {"<leader>d", group="debugger/diagnostics"},
    {"<leader>de", group="evaluate"},
    {"<leader>f", group="telescope/save"},
    {"<leader>fo", group="telescope symbols"},
    {"<leader>g", group="lsp goto ..."},
    {"<leader>c", group="norm/count"},
    {"<leader>cw", group="word/byte/line count"},
    {"<leader>r", group="reload/rename"},
    {"<leader>s", group="Slime/symbols/search"},
    {"<leader>p", group="python"},
    {"<leader>n", group="numbers"},
    {"<leader>l", group="lsp"},
    {"<leader>w", proxy="<C-w>", group="window"}
})
