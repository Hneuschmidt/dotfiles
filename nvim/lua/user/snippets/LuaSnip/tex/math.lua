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
-- Not complete alphabet
local greek_alphabet = {"alpha", "beta", "gamma", "Gamma", "delta", "Delta", "epsilon", "varepsilon", "zeta", "eta", "theta", "Theta", "iota", "kappa", "lambda", "Lambda", "mu", "nu", "omicron", "xi", "Xi", "pi", "Pi", "rho", "sigma", "Sigma", "tau", "upsilon", "Upsilon", "varphi", "phi", "Phi", "chi", "psi", "Psi", "omega", "Omega"}

local function isGreekChar(word)

    for _, char in ipairs(greek_alphabet) do
        if char == word then
            return true
        end
    end

    return false
end

return {
    -- greek
    s({trig=";a", snippetType="autosnippet"}, { t("\\alpha "),}),
    s({trig=";A", snippetType="autosnippet"}, { t("\\Alpha "),}),
    s({trig=";b", snippetType="autosnippet"}, { t("\\beta "),}),
    s({trig=";B", snippetType="autosnippet"}, { t("\\Beta "),}),
    s({trig=";c", snippetType="autosnippet"}, { t("\\chi "),}),
    s({trig=";C", snippetType="autosnippet"}, { t("\\Chi "),}),
    s({trig=";g", snippetType="autosnippet"}, { t("\\gamma "),}),
    s({trig=";G", snippetType="autosnippet"}, { t("\\Gamma "),}),
    s({trig=";d", snippetType="autosnippet"}, { t("\\delta "),}),
    s({trig=";D", snippetType="autosnippet"}, { t("\\Delta "),}),
    s({trig=";e", snippetType="autosnippet"}, { t("\\epsilon "),}),
    s({trig=";E", snippetType="autosnippet"}, { t("\\Epsilon "),}),
    s({trig=";z", snippetType="autosnippet"}, { t("\\zeta "),}),
    s({trig=";Z", snippetType="autosnippet"}, { t("\\Zeta "),}),
    s({trig=";t", snippetType="autosnippet"}, { t("\\theta "),}),
    s({trig=";T", snippetType="autosnippet"}, { t("\\Theta "),}),
    s({trig=";k", snippetType="autosnippet"}, { t("\\kappa "),}),
    s({trig=";K", snippetType="autosnippet"}, { t("\\Kappa "),}),
    s({trig=";l", snippetType="autosnippet"}, { t("\\lambda "),}),
    s({trig=";L", snippetType="autosnippet"}, { t("\\Lambda "),}),
    s({trig=";m", snippetType="autosnippet"}, { t("\\mu "),}),
    s({trig=";M", snippetType="autosnippet"}, { t("\\Mu "),}),
    s({trig=";r", snippetType="autosnippet"}, { t("\\rho "),}),
    s({trig=";R", snippetType="autosnippet"}, { t("\\Rho "),}),
    s({trig=";s", snippetType="autosnippet"}, { t("\\sigma "),}),
    s({trig=";S", snippetType="autosnippet"}, { t("\\Sigma "),}),
    s({trig=";o", snippetType="autosnippet"}, { t("\\omega "),}),
    s({trig=";O", snippetType="autosnippet"}, { t("\\Omega "),}),

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
            {d(1, get_visual), i(2, "Nenner")}
        ),
        {condition = tex_utils.in_mathzone}

    ),

    
-- Function to check if the word is a Greek character

-- Create the snippet
    s({
    trig = "([a-zA-z]+)", -- Trigger string to activate the snippet
    wordTrig = true, -- Trigger snippet for whole words only
    regTrig = true,
    name = "Greek Character Snippet",
    dscr = "Inserts a snippet when a Greek character is found.",
    snippetType ="autosnippet",
    -- Define the snippet content
    -- Replace with your desired content 
    },
    fmta("\\<> ", {f(function(_, snip) return snip.captures[1] end)}),
    {
        condition = function(line, trigger, captures) return isGreekChar(trigger) and tex_utils.in_mathzone() end
    }
),

}
