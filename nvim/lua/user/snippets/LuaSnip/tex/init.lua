-- Get the current directory
local current_directory = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])")
-- Modify the package.path to include the relative path
package.path = package.path .. ';' .. current_directory .. '?.lua'
-- Require the file using the relative path
local header = require('header')
local get_visual = function(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- if SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end
header.get_visual = get_visual

return {
    -- environments
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

    s({trig="columns"},
        fmta(
        [[
        \begin{columns}
            \begin{column}{<>\textwidth}
                <>
            \end{column}
            \begin{column}{<>\textwidth}
                <>
            \end{column}
        \end{columns}
        ]],
        {
            i(1, "0.5"),
            i(3),
            i(2, "0.5"),
            i(0),
        }
        )
    ),

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

    s({trig="figg", dscr="Inserts a latex figure", snippetType="autosnippet"},
        fmta(
            [[
            \begin{figure}
                \<><>{<>}
                \caption{<>}
                \label{fig:<>}
            \end{figure}
            ]],
            {
                i(1, "includegraphics"),
                i(2, "[width=\\textwidth]"),
                i(3, "filename.png"),
                i(4, "Caption"),
                i(5, "label"),
            }
        )
    ),

    s({trig="subfigures"},
        fmta(
        [[
        \begin{figure}
        \begin{center}
            % 1st subfigure
            \begin{subfigure}{t}{<>}
            \includegraphics[width=\textwidth]{<>}
            \caption{<>}
            \label{fig:<>}
            \end{subfigure}
            % 2nd subfigure
            \begin{subfigure}{t}{<>}
            \includegraphics[width=\textwidth]{<>}
            \caption{<>}
            \label{fig:<>}
            \end{subfigure}
        \end{center}
        \end{figure}
        ]],
        {
            i(1, "0.5\\textwidth"),
            i(2, "figure1.png"),
            i(3, "Caption 1"),
            i(4, "Label 1"),
            i(5, "0.5\\textwidth"),
            i(6, "figure2.png"),
            i(7, "Caption 2"),
            i(8, "Label 2"),
        }
    )
    ),

    s({trig="itemm", dscr="Creates an itemize environment"},
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

    -- commands
    s({trig="it", dscr="Creates an \\item for itemize or enumerate environments."},
        {t("\\item ")}
    ),

    s({trig="itp", dscr="Creates an empty \\item[] for itemize or enumerate envs."},
        fmta("\\item[<>] <>", {i(1), i(0)})
    ),

    s({trig="hr", dscr="The hyperref package's href{}{} command (url links)"},
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1, "url"),
                d(2, header.get_visual),
            }
        )
    ),

    s({trig="tii", dscr = "Expands 'tii' into \\textit{}"},
        fmta("\\textit{<>}",
            {
              d(1, header.get_visual),
            }
        )
    ),

    s({trig="tbr", dscr = "Expands 'tsr' into {}"},
        fmta("\\<>{<>} <>",
            {
              i(1, ""),
              d(2, header.get_visual),
              i(3, ""),
            }
        )
    ),

    s({trig="tem", dscr = "Expands 'tem' into \\emph{}"},
        fmta("\\emph{<>}",
            {
              d(1, header.get_visual),
            }
        )
    ),

    s({trig="tbf", dscr = "Expands 'tbf' into \\textbf{}"},
        fmta("\\textbf{<>}",
            {
              d(1, header.get_visual),
            }
        )
    ),

    s({trig="tcl", dscr = "Expands 'tcl' into \\textcolor{}{}"},
        fmta("\\textcolor{<>}{<>}",
            {
              i(1, "color"),
              d(2, header.get_visual),
            }
        )
    ),

    -- math shortcuts TODO move to math.lua TODO regex trigger to not trigger in words
    s({trig="mm", dscr="Creates a inline math mode via $ $", wordTrig=true, regTrig=false, snippetType="autosnippet"},
        fmta(
        [[
        $<>$
        ]],
        {
            d(1, header.get_visual),
        }
        )
    ),

    s({trig="ee", dscr="e to the power of selection", wordTrig=true, regTrig=false, snippetType="autosnippet"},
        fmta(
        "e^{<>}",
        {
            d(1, header.get_visual),
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
        {condition = header.in_tikz}
    ),

    s({trig="db", snippetType='autosnippet'},
            fmta(
            "\\draw <>;",
            {
            i(0),
            }
            ),
        {condition = header.in_tikz}
    ),

    s({trig="coordd", snippetType='autosnippet'},
            fmta(
            "\\coordinate <> at (<>);",
            {
            i(1),
            i(0),
            }
            ),
        {condition = header.in_tikz}
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

    s({trig="sim", dscr="Tilde (\\sim)", snippetType='autosnippet'},
        {t("\\sim")},
        {condition=header.in_mathzone}
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
        {condition=header.line_begin}
    ),

    s({trig="h1", dscr="Basic setup for a new section", snippetType='autosnippet'},
        fmta(
            [[
            \section{<>}
            \label{sec:<>}
            ]],
            {i(1), i(2)}
        ),
        {condition=header.line_begin}
    ),

    s({trig="h2", dscr="Basic setup for a new subsection", snippetType='autosnippet'},
        fmta(
            [[
            \subsection{<>}
            \label{sec:<>}
            ]],
            {i(1), i(2)}
        ),
        {condition=header.line_begin}
    ),

    s({trig="h3", dscr="Basic setup for a new subsubsection", snippetType='autosnippet'},
        fmta(
            [[
            \subsubsection{<>}
            \label{sec:<>}
            ]],
            {i(1), i(2)}
        ),
        {condition=header.line_begin}
    ),
 
    -- beamer
    s({trig="frmm", dscr="Create a beamer frame environment", wordTrig=true, snippetType="autosnippet" },
        fmta(
        [[
            \begin{frame}{<>}
                <>
            \end{frame}
        ]],
        {
            d(1, header.get_visual),
            i(0),
        }
        )

    ),
}
