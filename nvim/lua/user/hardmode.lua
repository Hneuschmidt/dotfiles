local status_ok, plug = pcall(require, "hardtime")
if not status_ok then
  return
end

plug.setup()
