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

    -- convoluted and long way to write a columns snippet
    s({trig="columns"},
        {
            t(
                {
                    "\\begin{columns}",
                    "   \\begin{column}{0.5\\textwidth}",
                    "       "
                }
            ),
            i(1, "Column1"),
            t(
                {
                    "",
                    "   \\end{column}",
                    "   \\begin{column}{0.5\\textwidth}",
                    "       ",
                }
            ),
            i(2, "Column2"),
            t(
                {
                    "",
                    "   \\end{column}",
                    "\\end{columns}",
                }
            ),
        }
    ),


    -- TODO move to a environments file
    s({trig="eq", dscr="A latex equation environment"},
        fmta(
        [[
            \begin{equation}
                <>
            \end{equation}
        ]],
        {i(0)}
        )

    ),

    s({trig="frmm", dscr="Create a beamer frame environment", wordTrig=true, snippetType="autosnippet" },
        fmta(
        [[
            \begin{frame}
                \frametitle{<>}
                <>
            \end{frame}
        ]],
        {
            d(1, get_visual),
            i(0),
        }
        )

    ),

    s({trig="envv", snippetType="autosnippet"},
        fmta(
        [[
            \begin{<>}
                <>
            \end{<>}

        ]],
        {
            i(1, "env"),
            i(0),
            rep(1, "env"),
        }
        )
    ),

    s({trig="hr", dscr="The hyperref package's href{}{} command (url links)"},
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1, "url"),
                i(2, "name"),
            }
        )
    ),

    s({trig="tii", dscr = "Expands 'tii' into \\textit{}"},
        fmta("\\textit{<>}",
            {
              d(1, get_visual),
            }
        )
    ),

    s({trig="tbr", dscr = "Expands 'tsr' into {}"},
        fmta("\\<>{<>} <>",
            {
              i(1, ""),
              d(2, get_visual),
              i(3, ""),
            }
        )
    ),

    s({trig="tem", dscr = "Expands 'tem' into \\emph{}"},
        fmta("\\emph{<>}",
            {
              d(1, get_visual),
            }
        )
    ),

    s({trig="tbf", dscr = "Expands 'tbf' into \\textbf{}"},
        fmta("\\textbf{<>}",
            {
              d(1, get_visual),
            }
        )
    ),

    s({trig="tcl", dscr = "Expands 'tcl' into \\textcolor{}{}"},
        fmta("\\textcolor{<>}{<>}",
            {
              i(1, "color"),
              d(1, get_visual),
            }
        )
    ),

    s({trig="figuree", dscr="Inserts a latex figure using \\includegraphics"},
        fmta(
            [[
            \begin{figure}
                \includegraphics[width=0.5\textwidth]{<>}
                \caption{<>}
                \label{fig:<>}
            \end{figure}
            ]],
            {
                i(1, "filename.png"),
                i(2, "Caption"),
                i(3, "label"),
            }
        )
    ),

    s({trig="subfigures"},
        fmta(
        [[
        \begin{figure}
        \centering
            % 1st subfigure
            \begin{subfigure}{t}{0.4\textwidth}
            \includegraphics[width=0.5\textwidth]{<>}
            \caption{<>}
            \label{fig:<>}
            \end{subfigure}
            % 2nd subfigure
            \begin{subfigure}{t}{0.4\textwidth}
            \includegraphics[width=0.5\textwidth]{<>}
            \caption{<>}
            \label{fig:<>}
            \end{subfigure}
        \end{figure}
        ]],
        {
            i(1, "figure1.png"),
            i(2, "Caption 1"),
            i(3, "Label 1"),
            i(4, "figure2.png"),
            i(5, "Caption 2"),
            i(6, "Label 2"),
        }
    )
    ),

    s({trig="item", dscr="Creates an itemize environment"},
        fmta(
        [[
        \begin{itemize}
            \item <>
        \end{itemize}
        ]],
        {i(0)}
        )
    ),

    s({trig="enum", dscr="Creates an enumerate environment"},
        fmta(
        [[
        \begin{enumerate}
            \item <>
        \end{enumerate}
        ]],
        {i(0)}
        )
    ),


    s({trig="it", dscr="Creates an \\item for itemize or enumerate environments."},
        {t("\\item ")}
    ),

    s({trig="itp", dscr="Creates an empty \\item[] for itemize or enumerate envs."},
        {t("\\item[] ")}
    ),

    s({trig="mm", dscr="Creates a inline math mode via $ $", wordTrig=true, regTrig=false, snippetType="autosnippet"},
        fmta(
        [[
        <>$<>$
        ]],
        {
            f(return_capture),
            d(1, get_visual),
        }
        )
    ),

    s({trig="ee", dscr="e to the power of selection", wordTrig=true, regTrig=false, snippetType="autosnippet"},
        fmta(
        "<>e^{<>}",
        {
            f(return_capture),
            d(1, get_visual),
        }
        )
    ),
    
    -- Tikz
    s({trig="dd", snippetType='autosnippet'},
            fmta(
            "\\draw[<>] <>;",
            {
            i(1, "params"),
            i(0),
            }
            ),
        {condition = tex_utils.in_tikz}
    ),

    s({trig="db", snippetType='autosnippet'},
            fmta(
            "\\draw <>;",
            {
            i(0),
            }
            ),
        {condition = tex_utils.in_tikz}
    ),

    s({trig="coordd", snippetType='autosnippet'},
            fmta(
            "\\coordinate <> at (<>);",
            {
            i(1),
            i(0),
            }
            ),
        {condition = tex_utils.in_tikz}
    ),

    s({trig="ccc", snippetType='autosnippet'},
            fmta(
            "\\cite{<>} <>",
            {
            i(1),
            i(0),
            }
            )
    ),

    s({trig="d..", dscr="Turns ... into \\dots"},
        {t("\\dots")}
    ),

    s({trig="cm", dscr="Checkmark"},
        {t("\\checkmark")}
    ),

    s({trig="sim", dscr="Tilde (\\sim)"},
        {t("\\sim")},
        {condition=tex_utils.in_mathzone}
    ),

    -- Sectioning
    s({trig="h0", dscr="Basic setup for a new chapter", snippetType='autosnippet'},
        fmta(
            [[
            \chapter{<>}
            \label{chap:<>}
            ]],
            {i(1), i(2)}
        ),
        {condition=line_begin}
    ),

    s({trig="h1", dscr="Basic setup for a new section", snippetType='autosnippet'},
        fmta(
            [[
            \section{<>}
            \label{sec:<>}
            ]],
            {i(1), i(2)}
        ),
        {condition=line_begin}
    ),

    s({trig="h2", dscr="Basic setup for a new subsection", snippetType='autosnippet'},
        fmta(
            [[
            \subsection{<>}
            \label{sec:<>}
            ]],
            {i(1), i(2)}
        ),
        {condition=line_begin}
    ),

    s({trig="h3", dscr="Basic setup for a new subsubsection", snippetType='autosnippet'},
        fmta(
            [[
            \subsubsection{<>}
            \label{sec:<>}
            ]],
            {i(1), i(2)}
        ),
        {condition=line_begin}
    ),


}
