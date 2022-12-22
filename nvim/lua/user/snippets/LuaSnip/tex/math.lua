-- THIS PART NEEDS TO BE COPIED EVERY TIME --
local get_visual = function(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- if SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

local return_capture = function(_, snip) return snip.captures[1] end
local line_begin = require("luasnip.extras.expand_conditions").line_begin


-- Latex-specific conditional expansio funcitions (requires VimTex)
local tex_utils = {}
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

-- END OF PART THAT GETS COPIED

return {
    s({trig=";a", snippetType="autosnippet"},
        {
            t("\\alpha"),
        }
    ),

    s({trig=";b", snippetType="autosnippet"},
        {
            t("\\beta"),
        }
    ),

    s({trig=";g", snippetType="autosnippet"},
        {
            t("\\gamma"),
        }
    ),

    s({trig="ff",
        dscr="Expand 'ff' into \frac{}{}",
        regTrig=false,
        wordTrig=true,
        snippetType="autosnippet"
       },
        fmta(
            [[
                \frac{<>}{<>}
            ]],
            {i(1, "Zähler"), i(2, "Nenner")}
        ),
        {condition = tex_utils.in_mathzone}

    ),
}
