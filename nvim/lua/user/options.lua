local options = {
    number=true,
    relativenumber=true,
	fileencoding = "utf-8",
	showtabline = 2,
	splitbelow = true,
	splitright = true,
	completeopt = { "menuone", "noselect" },
	cursorline = true,
	expandtab = true,
	tabstop = 4,
  shiftwidth=0,
	mouse = "a",
	numberwidth = 4,
	updatetime = 300,
	signcolumn = "yes",
    wildignorecase = true,
    ignorecase = true,
}

local opt = vim.opt

opt.shortmess:append "c"

for k, v in pairs(options) do
	opt[k] = v
end

opt.path:append "src/**"
opt.wildignore:append "**/target/*"
opt.wildignore:append "**/__pycache__/*"
opt.wildignore:append "**/.git/*"
opt.wildignore:append "**/build/*"
