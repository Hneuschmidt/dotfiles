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
keymap("n", "<localleader>ee", "A \\\\<Esc>", desc_opts("add \\\\ to the end of a line (linebreak in latex)"))
keymap("n", "<localleader>aa", "a & ", desc_opts("insert ' & ' (new table item in latex)"))

keymap("v", "<localleader>ea", ":EasyAlign ", opts)
keymap("v", "<localleader>el", ":LiveEasyAlign ", opts)
keymap("v", "<localleader>et", ":EasyAlign *&", opts)

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
keymap("n", "gp", "vipo<Esc>", desc_opts("Move cursor to start of paragraph"))
keymap("n", "gP", "vipoo<Esc>", desc_opts("Move cursor to end of block"))

local _, builtin = pcall(require, "telescope.builtin")
-- local builtin = require("telescope.builtin")

-- Telescope
vim.keymap.set("n", "<leader>ff", builtin.find_files, desc_opts("telescope find files"))
vim.keymap.set("n", "<leader>fg", builtin.live_grep, desc_opts("telescope live grep"))
vim.keymap.set("n", "<leader>fb", builtin.buffers, desc_opts("telescope buffers"))
vim.keymap.set("n", "<leader>fh", builtin.help_tags, desc_opts("telescope help_tags"))
vim.keymap.set("n", "<leader>fot", builtin.treesitter, desc_opts("telescope treesitter"))
vim.keymap.set("n", "<leader>fob", builtin.lsp_document_symbols, desc_opts("telescope lsp document symbols"))
vim.keymap.set("n", "<leader>fod", builtin.diagnostics, desc_opts("telescope diagnostics"))
vim.keymap.set("n", "<leader>fk", builtin.keymaps, desc_opts("telescope keymaps"))
vim.keymap.set("n", "<leader>fd", "<Cmd>Telescope file_browser<CR>", desc_opts("telescope file browser"))

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

-- Navigate command mode

-- Emacs style bindings in command mode
keymap("c", "<C-a>", "<Home>", opts)
keymap("c", "<C-e>", "<End>", opts)
keymap("c", "<M-f>", "<S-Right>")
keymap("c", "<M-b>", "<S-Left>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Terminal --
-- Better terminal navigation
keymap("n", "<leader>t", "<CMD>botright 14 split term://bash<CR>a", desc_opts("open a terminal") )  -- open a terminal
keymap("n", "<leader>pi", "<CMD>botright 14 split term://ipython<CR>a", desc_opts("open iPython repl") )  -- open an ipython console
keymap("n", "<leader>pp", "<CMD>botright 14 split term://python<CR>a", desc_opts("open Python repl") )  -- open a python console
keymap("n", "<leader>j", "<CMD>botright 14 split term://julia --project=.<CR>a", desc_opts("open Julia repl") )  -- open a julia console

keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- interface
keymap("n", "<leader>nr", "<CMD>set relativenumber!<CR>", desc_opts("toggle linear line numbers"))
keymap("n", "<leader>na", "<CMD>set number!<CR>", desc_opts("toggle relative line numbers"))

-- DAP
keymap("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc_opts("toggle Breakpoint"))
keymap("n", "<leader>dr", "<CMD>DapToggleRepl<CR>", desc_opts("toggle DAP repl"))
keymap("n", "<leader>dc", "<CMD>DapContinue<CR>", desc_opts("continue (debugger)"))
keymap("n", "<leader>di", "<CMD>DapStepInto<CR>", desc_opts("step into (debugger)"))
keymap("n", "<leader>do", "<CMD>DapStepOver<CR>", desc_opts("step over (debugger)"))
keymap("n", "<leader>dO", "<CMD>DapStepOut<CR>", desc_opts("step out (debugger)"))
keymap("n", "<leader>dk", "<CMD>DapTerminate<CR>", desc_opts("terminate (debugger)"))
keymap("n", "<leader>du", "<CMD>lua require('dapui').toggle()<CR>", desc_opts("toggle DAP ui"))
keymap("n", "<leader>dt", "<CMD>lua require('dap-python').test_method()<CR>", desc_opts("test and debug method under cursor (dap-python)"))
