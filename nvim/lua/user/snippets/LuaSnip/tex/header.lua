-- THIS PART NEEDS TO BE COPIED EVERY TIME --
local tex_utils = {}

local return_capture = function(_, snip) return snip.captures[1] end
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Latex-specific conditional expansio funcitions (requires VimTex)
tex_utils.return_capture = return_capture
--tex_utils.get_visual = get_visual
tex_utils.line_begin = line_begin

tex_utils.in_mathzone = function ()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

tex_utils.in_text = function ()
    return not tex_utils.in_mathzone()
end

tex_utils.in_commment = function ()
    return vim.fn['vimtex#syntax#in_comment']() == 1
end

tex_utils.in_env = function(name)
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

tex_utils.in_tikz = function()
    return tex_utils.in_env('tikzpicture')
end

--variables
--a

-- END OF PART THAT GETS COPIED
return tex_utils


