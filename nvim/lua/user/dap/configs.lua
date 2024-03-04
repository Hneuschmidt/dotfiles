local status_ok, dap = pcall(require, "dap")
if not status_ok then
	print("dap not okay")
  return
end

dap.configurations.rust = {
    {
        name = "Launch",
        type= "lldb",
        request = "launch",
        program = function ()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

