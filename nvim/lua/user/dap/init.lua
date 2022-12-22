-- example conf here: https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57

local status_ok, dap = pcall(require, "dap")
if not status_ok then
	print("dap not okay")
  return
end

dap.adapters.lldb = {
    type="server",
    name="lldb",
    port="${port}",
    executable = {
        command="/Users/hannes/.local/share/nvim/mason/bin/codelldb",
        args={"--port", "${port}"},
    }
}

-- dap.adapters.cppdbg = {
--     id = "cppdbg",
--     type = "executable",
--     command = "/Users/hannes/.local/share/nvim/mason/packages/cpptools/extension/bin/cpptools",
--   }

require "user.dap.configs"

require("dapui").setup()

require("nvim-dap-virtual-text").setup()

