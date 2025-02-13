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
        },
        custom_highlights = function(colors)
            return {
                --TabLineSel = {bg = colors.pink},
                String = { fg = colors.yellow},
                Type = { fg = colors.flamingo},
                Number = { fg = colors.green},
--                Keyword = { fg = colors.green},
--                Function = { fg = colors.blue },
                Operator = {fg = colors.peach},
--                Conditional = {fg = colors.red},
--                Return = {bg = colors.red},
                CursorLine = {bg = colors.surface1},
                StatusLine = {bg = colors.surface2},
                StatusLineNC = {bg = colors.surface0, fg = colors.subtext1},
                DebugPC = {fg = colors.green},
                DapBreakpoint = {fg = colors.peach},
                --SignColumn = {fg = colors.green},
                Comment = {fg = colors.overlay1},
                --Constant = {fg = colors.pink},
            }
        end
    })

    vim.cmd.colorscheme "catppuccin"
end

-- TODO move to treesitter config
vim.api.nvim_set_hl(0, "@keyword.function.python", { link = "Keyword"})
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type"})
--vim.api.nvim_set_hl(0, "@variable.parameter", { link = "Constant"})

vim.fn.sign_define('DapBreakpoint', {text="", texthl="DapBreakpoint"})
vim.fn.sign_define('DapStopped', {text = "󰜴", texthl="DebugPC"})
