--print("start lsp configs.lua")
local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
--	print("status not okay, mason")
	return
end
--print("status okay, mason")

local lspconfig = require("lspconfig")
--print "Lspconfig loaded"

-- solve rust analyzer complaining about cancelled request
-- https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic'}) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

local servers = { "jsonls", "lua_ls", "pyright", "rust_analyzer", "julials", "cssls", "html", "texlab", "clangd", "marksman", "wgsl_analyzer", "taplo", "jdtls"}

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
