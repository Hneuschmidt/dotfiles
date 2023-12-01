local get_visual = function(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- if SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end


return {
--     s({trig="envv", snippetType="autosnippet"},
--         fmta(
--         [[
--             \begin{<>}
--                 <>
--             \end{<>}
-- 
--         ]],
--         {
--             i(1, "env"),
--             i(0),
--             rep(1, "env"),
--         }
--         )
--     ),

--    s({trig="it", dscr="Creates an \\item for itemize or enumerate environments."},
--        {t("\\item ")}
--    ),

    s({trig="modtest", dscr="Creates a test module.", snippetType="autosnippet"},
        fmta(
        [[
        #[cfg(test)]
        mod tests {
            use super::*;

            #[test]
            fn test_<>() {
                assert!(false);
            }
        }
        ]],

        {
        i(1)
        }
        )

    ),

}
