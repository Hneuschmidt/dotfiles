local status_ok, outl = pcall(require, "symbols-outline")
if not status_ok then
  return
end

outl.setup()
