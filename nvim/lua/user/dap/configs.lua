local status_ok, dap = pcall(require, "dap")
if not status_ok then
	print("dap not okay")
  return
end

local function get_current_dir(path)
    local _, _, dir = path:find(".*/(.-)/?$")
    return dir or ""
end

dap.configurations.rust = {
    {
        name = "Launch",
        type= "lldb",
        request = "launch",
        program = function ()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/" .. get_current_dir(vim.fn.getcwd()), "file")
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function ()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
    },
}


dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

local status_ok, dappython = pcall(require, "dap-python")
if not status_ok then
    print("dap-python not okay")
else
    dappython.setup("~/micromamba/envs/dap/bin/python")
    table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Logging pass through",
        program = "pytest",
        args = {"--log_cli", "true"}
    })
end
