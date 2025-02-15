local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
    print "obsidian not found"
    return
end

local _, setup_ok = pcall(obsidian.setup, {
    workspaces  ={
        {
            name = "BC",
            path = "~/Documents/BC"
        },
    }
})

if not setup_ok then
    print "could not setup obsidian"
    return
end

