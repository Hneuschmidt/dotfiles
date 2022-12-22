return {
s({trig="env", snippetType="autosnippet"},
    fmta(
        [[
            \begin{<>}
                <>
            \end{<>}
        ]],
        {i(1), i(2), rep(1),}
    )
),
	s({trig="test", snippetType="autosnippet"},
		{t("just a test"),
		}
	)
}

