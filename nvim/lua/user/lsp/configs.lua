--print("start lsp configs.lua")
local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
--	print("status not okay, mason")
	return
end
--print("status okay, mason")

local lspconfig = require("lspconfig")
--print "Lspconfig loaded"

local servers = { "jsonls", "lua_ls", "pyright", "rust_analyzer", "julials", "cssls", "html", "texlab", "clangd", "marksman", "matlab_ls", "wgsl_analyzer", "typst_lsp"}

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
