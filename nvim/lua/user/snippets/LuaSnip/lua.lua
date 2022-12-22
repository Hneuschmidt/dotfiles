local get_visual = function(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- if SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

return {
    s({trig="snip", name="name", dscr="snippet template"},
        fmta(
            [[
            s({trig=<><>},
                {
                    <>,
                }
            ),
            ]],
        {
                i(1, "trigger"),
                i(2, ", snippetType='autosnippet'"),
                i(3, "t()"),
        }
       )
    ),

    s({trig="fmta"},
        {
            t({"fmta(", "[[", ""}),
            i(1, "body"),
            t({"", "]],", "", "{", ""}),
            i(2, "i(1)"),
            t({"", "}", ")"})
        }
    ),
}
