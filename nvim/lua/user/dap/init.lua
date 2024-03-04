-- example conf here: https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57

local status_ok, dap = pcall(require, "dap")
if not status_ok then
	print("dap not okay")
  return
end

--local md_status_ok, mason_dap = pcall(require, "mason-nvim-dap")
--if not md_status_ok then
--	print("mason nvim dap not okay")
--  return
--end

-- mason_dap.setup({ ensure_installed = {"codelldb"}, handlers = {}})

dap.adapters.lldb = {
    type="server",
    name="lldb",
    port="${port}",
    executable = {
        command="/home/ubuntu/.local/share/nvim/mason/bin/codelldb",
        args={"--port", "${port}"},
    }
}
--dap.adapters.lldb = {
--    type = "executable",
--    command = "/home/hannes/.local/share/nvim/mason/bin/codelldb",
--    name = "lldb",
--}

require "user.dap.configs"

require("dapui").setup()

--require("nvim-dap-virtual-text").setup()

