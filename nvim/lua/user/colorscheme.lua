-- vim.cmd [[
-- try
--   colorscheme onenodr
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

-- local status_ok, onenord = pcall(require, "twonord")
-- if not status_ok then
--     local status_ok, onenord = pcall(require, "onenord")
--     if not status_ok then
--         vim.cmd("colorscheme default")
--     else 
--         onenord.setup()
--     end
--     return
-- end
-- 
-- 
-- onenord.setup()
--
local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    vim.cmd.colorscheme "default"
else
    catppuccin.setup({
        styles = {
            conditionals = {},
        }
    })

    vim.cmd.colorscheme "catppuccin"
end

