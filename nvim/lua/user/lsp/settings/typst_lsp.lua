return {
    settings = {
        exportPdf = "onSave"
    },
    root_dir = function ()
        return vim.fn.getcwd()
    end
}
