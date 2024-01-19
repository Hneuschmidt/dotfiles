local status_ok, outl = pcall(require, "outline")
if not status_ok then
  return
end

outl.setup()
