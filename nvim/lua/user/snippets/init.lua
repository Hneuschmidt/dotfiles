vim.cmd("let g:tex_flavor='latex'")

local status_ok_snip, snip  = pcall(require, "luasnip")
if not status_ok_snip then
  return
end

local status_ok_ld, ld  = pcall(require, "luasnip.loaders.from_lua")
if not status_ok_ld then
  return
end

-- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})
-- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/user/snippets/LuaSnip/"})
--snip.config.set_config({
snip.config.setup({
    enable_autosnippets=true,
    -- use tab to trigger visual selection
    store_selection_keys = "<Tab>",
    update_events = "TextChanged,TextChangedI",
})

--ld.lazy_load({paths = "~/.config/nvim/lua/user/snippets/LuaSnip/"})
ld.load({paths = "~/.config/nvim/lua/user/snippets/LuaSnip/"})



-- alternative
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
--  
-- " Jump forward through tabstops in visual mode
-- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

vim.cmd([[
 " Expand snippets in insert mode with Tab
 imap <silent><expr> <C-l> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<C-l>'
 
  " Jump forward in through tabstops in insert and visual mode with Control-ö
 imap <silent><expr> <C-ö> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-ö>'
 smap <silent><expr> <C-ö> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-ö>'

 " Jump backward through snippet tabstops with Shift-Tab (for example)
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

]])


-- for choice mode
-- " Cycle forward through choice nodes with Control-f (for example)
-- imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
-- smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'


-- Fast reload snippets
vim.keymap.set(
    "n",
    "<leader>rs",
    "<Cmd>lua require('luasnip.loaders.from_lua').load({paths= '~/.config/nvim/lua/user/snippets/LuaSnip/'})<CR>"
)
