local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
    print "obsidian not found"
    return
end

obsidian.setup({
    workspaces  ={
        {
            name = "BC",
            path = "~/Documents/BC"
        },
    }
})

