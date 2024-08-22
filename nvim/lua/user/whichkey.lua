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
        }
    }
})
