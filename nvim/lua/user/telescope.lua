local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        i = {
            ["<C-l>"] = actions.which_key, -- TODO change
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
        },
        mappings = {
            n = {
                ["<leader>h"] = "which_key"
            },
        },
    },
    extensions = {
        file_browser = {theme="dropdown"},
    },
    pickers = {
        find_files = {theme="dropdown"},
        live_grep = {theme="dropdown"},
        file_browser = {theme="dropdown"},
    }
})

telescope.load_extension("file_browser")

-- local fb_status_ok, file_browser = pcall(require, "telescope.extentions.file_browser.file_browser")
-- if not fb_status_ok then
--   return
-- end



-- telescope.load_extention("dap")
