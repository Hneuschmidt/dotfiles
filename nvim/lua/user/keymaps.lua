local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
keymap("", "<S-k>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Rust specific
keymap("n", "<leader>lcf", ":!cargo fmt<CR><CR>", opts)
-- TODO Would be nice if we can go back to current position
keymap("n", "<leader>;", "A;<Esc>", opts)

-- Latex specific
keymap("n", "<leader>ee", "A \\\\<Esc>", opts)
keymap("n", "<leader>aa", "a & ", opts)

keymap("v", "<leader>ea", ":EasyAlign ", opts)
keymap("v", "<leader>el", ":LiveEasyAlign ", opts)
keymap("v", "<leader>et", ":EasyAlign *&", opts)

keymap("n", "<localleader>vc", "<CMD>VimtexCompile<CR>", opts)
keymap("n", "<localleader>vC", "<CMD>VimtexClean<CR>", opts)
keymap("n", "<localleader>vv", "<CMD>VimtexView<CR>", opts)


-- general niceties
keymap("n", "<leader>fs", "<cmd>w<CR>", opts)
keymap("n", "<leader>fq", "<cmd>wq<CR>", opts)
keymap("n", "<leader>sh", "<cmd>set hlsearch!<CR>", opts)
keymap("v", "<leader>cl", ":norm i", opts)
keymap("n", "<leader>cl", ":norm I", opts)
keymap("v", "<leader>cd", ":norm ", opts)
keymap("n", "<leader>cd", ":norm ", opts)

keymap("v", "<leader>cww", "<CMD>'<, '>w !wc -w<CR>", opts)  -- count words
keymap("v", "<leader>cwl", "<CMD>'<, '>w !wc -l<CR>", opts)  -- count words
keymap("v", "<leader>cwm", "<CMD>'<, '>w !wc -m<CR>", opts)  -- count words
keymap("n", "<leader>cww", "<CMD>w !wc -w<CR>", opts)  -- count words
keymap("n", "<leader>cwl", "<CMD>w !wc -l<CR>", opts)  -- count words
keymap("n", "<leader>cwm", "<CMD>w !wc -m<CR>", opts)  -- count words

-- jumps
keymap("n", "g{", "vipo<Esc>", opts)
keymap("n", "g}", "vipoo<Esc>", opts)
keymap("n", "gp", "vipo<Esc>", opts)
keymap("n", "gP", "vipoo<Esc>", opts)

local _, builtin = pcall(require, "telescope.builtin")
-- local builtin = require("telescope.builtin")

-- Telescope
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
vim.keymap.set("n", "<leader>fot", builtin.treesitter, opts)
vim.keymap.set("n", "<leader>fob", builtin.lsp_document_symbols, opts)
vim.keymap.set("n", "<leader>fod", builtin.diagnostics, opts)

vim.keymap.set("n", "<leader>fd", "<Cmd>Telescope file_browser<CR>", {noremap=true, silent=true})


-- Symbols outline

vim.keymap.set("n", "<leader>so", "<Cmd>:SymbolsOutline<CR>", opts)


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<leader>w", "<C-w>", opts)

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize
keymap("n", "<leader>O", ":resize -2<CR>", opts)
keymap("n", "<leader>o", ":resize +2<CR>", opts)
keymap("n", "<leader>I", ":vertical resize -2<CR>", opts)
keymap("n", "<leader>i", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
--keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
--keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
--keymap("v", "<A-j>", ":m .+1<CR>==", opts)
--keymap("v", "<A-k>", ":m .-2<CR>==", opts)
--keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
--keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
--keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
--keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
--keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("n", "<leader>t", ":botright split term://zsh<CR>a", opts )  -- open a terminal
keymap("n", "<leader>pi", ":botright split term://ipython<CR>a", opts )  -- open an ipython console
keymap("n", "<leader>pp", ":botright split term://python<CR>a", opts )  -- open a python console
keymap("n", "<leader>j", ":botright split term://julia --project=.<CR>a", opts )  -- open a julia console

keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts) 

-- interface
keymap("n", "<leader>nr", "<CMD>set relativenumber!<CR>", opts)
keymap("n", "<leader>na", "<CMD>set number!<CR>", opts)
