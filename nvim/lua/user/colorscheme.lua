vim.cmd [[
try
  colorscheme onenord
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

local status_ok, onenord = pcall(require, "twonord")
if not status_ok then
    local status_ok, onenord = pcall(require, "onenord")
    if not status_ok then
        vim.cmd("colorscheme default")
    else 
        onenord.setup()
    end
    return
end


onenord.setup()
