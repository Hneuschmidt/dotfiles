local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

local function desc_opts(desc)
    local new_opts = {}
    for k, v in pairs(opts) do
        new_opts[k] = v
    end
    new_opts["desc"] = desc
    return new_opts
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
keymap("", "<S-k>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Rust specific
keymap("n", "<leader>lcf", ":!cargo fmt<CR><CR>", desc_opts("run cargo fmt on project"))
-- TODO Would be nice if we can go back to current position
keymap("n", "<leader>;", "A;<Esc>", desc_opts("add a semicolon to the end of the line"))

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
keymap("n", "<leader>fs", "<cmd>w<CR>", desc_opts("save"))
keymap("n", "<leader>fq", "<cmd>wq<CR>", desc_opts("save and quit"))
keymap("n", "<leader>sh", "<cmd>set hlsearch!<CR>", desc_opts("toggle highlight search results"))
keymap("v", "<leader>cl", ":norm i", desc_opts("add text to start of selection (:norm i)"))
keymap("n", "<leader>cl", ":norm I", desc_opts("add text to start of line (:norm I)"))
keymap("v", "<leader>cd", ":norm ", opts)
keymap("n", "<leader>cd", ":norm ", opts)
keymap("n", "<leader>rf", "<CMD>source %<CR>", desc_opts("Source current file"))

keymap("v", "<leader>cww", "<CMD>'<, '>w !wc -w<CR>", desc_opts("count words in selection"))  -- count words
keymap("v", "<leader>cwl", "<CMD>'<, '>w !wc -l<CR>", desc_opts("count lines in selection"))  -- count words
keymap("v", "<leader>cwm", "<CMD>'<, '>w !wc -m<CR>", desc_opts("count bytes in selection"))  -- count words
keymap("n", "<leader>cww", "<CMD>w !wc -w<CR>", desc_opts("count words in file"))  -- count words
keymap("n", "<leader>cwl", "<CMD>w !wc -l<CR>", desc_opts("count lines in file"))  -- count words
keymap("n", "<leader>cwm", "<CMD>w !wc -m<CR>", desc_opts("count bytes in file"))  -- count words

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
vim.keymap.set("n", "<leader>fk", builtin.keymaps, opts)

vim.keymap.set("n", "<leader>fd", "<Cmd>Telescope file_browser<CR>", {noremap=true, silent=true})


-- Outline

vim.keymap.set("n", "<leader>so", "<Cmd>Outline<CR>", opts)


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

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Terminal --
-- Better terminal navigation
keymap("n", "<leader>t", "<CMD>botright 14 split term://zsh<CR>a", opts )  -- open a terminal
keymap("n", "<leader>pi", "<CMD>botright 14 split term://ipython<CR>a", opts )  -- open an ipython console
keymap("n", "<leader>pp", "<CMD>botright 14 split term://python<CR>a", opts )  -- open a python console
keymap("n", "<leader>j", "<CMD>botright 14 split term://julia --project=.<CR>a", opts )  -- open a julia console

keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts) 

-- interface
keymap("n", "<leader>nr", "<CMD>set relativenumber!<CR>", opts)
keymap("n", "<leader>na", "<CMD>set number!<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", opts)
keymap("n", "<leader>dr", "<CMD>DapToggleRepl<CR>", opts)
keymap("n", "<leader>dc", "<CMD>DapContinue<CR>", opts)
keymap("n", "<leader>di", "<CMD>DapStepInto<CR>", opts)
keymap("n", "<leader>do", "<CMD>DapStepOver<CR>", opts)
keymap("n", "<leader>dO", "<CMD>DapStepOut<CR>", opts)
keymap("n", "<leader>dk", "<CMD>DapTerminate<CR>", opts)
keymap("n", "<leader>du", "<CMD>lua require('dapui').toggle()<CR>", opts)
keymap("n", "<leader>dt", "<CMD>lua require('dap-python').test_method()<CR>", opts)
