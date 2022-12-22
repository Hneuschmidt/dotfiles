local get_visual = function(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- if SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

return {
    s({trig="sp", descr = "surrounds the current selection by parentheses"},
        fmta("<>(<>)",
            {
              i(2, "function"),
              d(1, get_visual),
            }
        )
    ),

    s({trig="ifm", descr = "creates the \"if __name__ == '__main__':\" block "},
        fmta(
        [[
            if __name__ == "__main__":
                <>
        ]],
        {i(0, "pass")}
        )
    ),

}
