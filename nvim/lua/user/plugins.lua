local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({"wbthomason/packer.nvim"}) 		-- packer to manage itself
	use({"nvim-lua/plenary.nvim"}) 			-- useful lua functionality

	use({"williamboman/mason.nvim"}) 		-- lsp/dap etc installer
    use({"williamboman/mason-lspconfig.nvim"})

	-- colorschemes
	use({"lunarvim/darkplus.nvim"})
	use({"arcticicestudio/nord-vim"})
    use({"Hneuschmidt/twonord.nvim"})
    use({"catppuccin/nvim", as = "catppuccin"})
	--use({"rmehri01/onenord.nvim"})

	-- snippets
	use({ "L3MON4D3/LuaSnip"}) --snippet engine
	use({ "rafamadriz/friendly-snippets"}) -- a bunch of snippets to use

	-- completion
	use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
	 use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- lsp
	use({ "neovim/nvim-lspconfig"}) -- enable LSP
	-- use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }) -- for formatters and linters
    --use({"simrat39/symbols-outline.nvim"})
    use({"hedyhli/outline.nvim"})

    -- dap
    use({ "mfussenegger/nvim-dap" })
    use({"jay-babu/mason-nvim-dap.nvim"})
    use({ "theHamsta/nvim-dap-virtual-text" })

    use("nvim-neotest/nvim-nio")
    use({ "rcarriga/nvim-dap-ui" , requires = {"mfussenegger/nvim-dap"}})

    -- latex specific
    use ({"lervag/vimtex"})
    use ({"junegunn/vim-easy-align"})

    -- typst specific
    use ( {"kaarmu/typst.vim"} )

    -- julia specific
    -- use({"adelarsq/vim-matchit"})
    use({"juliaeditorsupport/julia-vim" })

    -- navigation
    --use({ "nvim-telescope/telescope.nvim", tag="0.1.0"})
    use({ "nvim-telescope/telescope.nvim"})
    use({ "nvim-telescope/telescope-file-browser.nvim"})
    use({ "ggandor/leap.nvim",
        config=function()
            require("leap").add_default_mappings()
        end
    })

    -- hard mode
    --use("MunifTanjim/nui.nvim")
    --use("m4xshen/hardtime.nvim")

	-- treesitter
	use({"nvim-treesitter/nvim-treesitter"})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
    --

    -- repl
    use({"jpalardy/vim-slime"})

    -- Parenthesis support
    use({"kylechui/nvim-surround",
        tag="*",
        config=function()
            require("nvim-surround").setup({})
        end
    })
    use {"windwp/nvim-autopairs",
        config = function ()
            require("nvim-autopairs").setup{}
        end
    }

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
