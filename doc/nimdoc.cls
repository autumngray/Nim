\ProvidesClass{nimdoc}[2022/04/17, 2018/01/01 LaTeX2e nonstandard class]

\LoadClass[a4paper,11pt]{article}

\usepackage[a4paper,xetex,left=3cm,right=3cm,top=1.5cm,bottom=2cm]{geometry}

%   for 2-sided printing with larger inner "binding" margin
%\usepackage[a4paper,xetex,twoside,left=4cm,right=2cm,top=1.5cm,bottom=2cm]{geometry}
%   for e-readers with 1.77:1 aspect ratio (e.g. 1920x1080)
%\usepackage[xetex,paperheight=27.6cm,paperwidth=15.5cm,left=3mm,right=3mm,top=3mm,bottom=3mm]{geometry}
%   for e-readers with 1.45:1 aspect ratio (e.g. 1200x825)
%\usepackage[xetex,paperheight=22.5cm,paperwidth=15.5cm,left=3mm,right=3mm,top=3mm,bottom=3mm]{geometry}
%   for e-readers with 1.33:1 aspect ratio (e.g. 1872x1404)
%\usepackage[xetex,paperheight=20.7cm,paperwidth=15.5cm,left=3mm,right=3mm,top=3mm,bottom=3mm]{geometry}

\usepackage{fontspec}
% logic to select default font with some fall-back fonts.
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}  % the default font
  \typeout{========================================= nim: using Times New Roman}
}{
  \IfFontExistsTF{FreeSerif}{%
    \setmainfont{FreeSerif}  % fallback #1 - official GNU font, resembles Times
    \typeout{========================================= nim: using FreeSerif}
  }{
    \IfFontExistsTF{DejaVuSerif}{%
      \setmainfont{DejaVuSerif}  % fallback #2 - very widespread free font
      \typeout{========================================= nim: using DejaVuSerif}
    }{
      \typeout{!!!!!!!!!!!!!!!!!!! Fonts not found !!!!!!!!!!!!!!!!!!!!!!!}
    }
  }
}

% default monospace font for code:
\usepackage{GoMono}
\usepackage{relsize}
% make this monospace font 2 steps smaller to hold 80-character line
\newcommand{\rstverbblockfont}{\smaller[2]}
\newcommand{\rstverbinlinefont}{\smaller}

\usepackage{parskip}  % paragraphs delimited by vertical space, no indent
\usepackage{graphicx}

\usepackage{makeidx}
\newcommand{\nimindexterm}[2]{#2\index{#2}\label{#1}}
\makeindex

\usepackage{dingbat} % for \carriagereturn, etc
\usepackage{fvextra}  % for code blocks (works better than original fancyvrb)
\fvset{
  breaklines,
  breakafter={=}:|\_\{\}[](){,}.;+-*/'",
  breaksymbolleft=\color{red}{\ensuremath{\hookrightarrow}},
  breaksymbolright=\color{red}{\small\carriagereturn}
}
\fvinlineset{%
   breaklines,
   breakafter={=}:|\_\{\}[](){,}.;+-*/'",
     % that does not work at all when we underline inline code by ulem :-(
   commandchars=\\\{\}
}

\usepackage{scrextend}  % for the `addmargin` environment

\usepackage{xcolor}
\usepackage[urlbordercolor=blue,linkbordercolor=cyan,
            pdfborderstyle={/S/U/W 1}]{hyperref}
\usepackage{enumitem}  % for option list, enumList, and rstfootnote

\usepackage[most]{tcolorbox}  % boxes around admonitions, code blocks, doc.item

\newtcolorbox{rstadmonition}[1][]{blanker, breakable,
     left=3mm, right=0mm, top=1mm, bottom=1mm,
     before upper=\indent, parbox=false, #1}

\newtcolorbox{rstquote}[1][]{blanker, breakable,
     left=3mm, right=3mm, top=1mm, bottom=1mm,
     parbox=false,
     borderline west={0.3em}{0pt}{lightgray},
     borderline north={0.05em}{0pt}{lightgray},
     borderline east={0.05em}{0pt}{lightgray},
     borderline south={0.05em}{0pt}{lightgray}}

\definecolor{rstframecolor}{rgb}{0.85, 0.8, 0.6}

\newtcolorbox{rstprebox}[1][]{blanker, breakable,
     left=3mm, right=3mm, top=1mm, bottom=1mm,
     borderline ={0.1em}{0pt}{rstframecolor},
     before upper=\indent, parbox=false, #1}

\newenvironment{rstpre}{%
\VerbatimEnvironment\begingroup\begin{rstprebox}%
\begin{Verbatim}[fontsize=\rstverbblockfont , commandchars=\\\{\}]}%
{\end{Verbatim}\end{rstprebox}\endgroup}

\newtcolorbox{rstdocitembox}[1][]{blanker, breakable,
     left=3mm, right=3mm, top=1mm, bottom=1mm,
     borderline ={1pt}{0pt}{cyan},
     before upper=\indent, parbox=false, #1}

% Inline code formatting: grey underline,
% use \Verb from fvextras e.g. to display -- correctly as double -
\usepackage[normalem]{ulem}
\newcommand\rstuline{\bgroup\markoverwith{\textcolor{rstframecolor}{\rule[-0.8ex]{2pt}{1.0pt}}}\ULon}

\newcommand{\rstcode}[1]{%
{\rstverbinlinefont\Verb{\rstuline{#1}}}%
}

\newcommand{\rstcodeitem}[1]{\Verb{#1}}

\newenvironment{rstdocitem}{%
\VerbatimEnvironment\begingroup\begin{rstdocitembox}%
\begin{Verbatim}[fontsize=\rstverbblockfont , commandchars=\\\{\}]}%
{\end{Verbatim}\end{rstdocitembox}\endgroup}


\newenvironment{rstfootnote}{\begin{description}[labelindent=1em,leftmargin=1em,labelwidth=2.6em]}{\end{description}}
\ifdim\linewidth<30em
  \def\rstoptleftmargin{0.4\linewidth}
  \def\rstoptlabelwidth{0.35\linewidth}
\else
  \def\rstoptleftmargin{12em}
  \def\rstoptlabelwidth{10.5em}
\fi
\newenvironment{rstoptlist}{%
\begin{description}[font=\sffamily\bfseries,style=nextline,leftmargin=\rstoptleftmargin,labelwidth=\rstoptlabelwidth]}{\end{description}}

\usepackage{tabulary}  % tables with adjustable cell width and no overflow
% make tabulary prevent overflows (https://tex.stackexchange.com/a/195088)
\tymin=60pt
\tymax=\maxdimen
% to pack tabulary into a new environment, special syntax is needed :-(
\newenvironment{rsttab}[1]{\tabulary{\linewidth}{#1}}{\endtabulary}

\newcommand{\rstsub}[1]{\raisebox{-0.5ex}{\scriptsize{#1}}}
\newcommand{\rstsup}[1]{\raisebox{0.5ex}{\scriptsize{#1}}}

\newcommand{\rsthA}[2][]{\section[#1]{#2}}
\newcommand{\rsthB}[2][]{\subsection[#1]{#2}}
\newcommand{\rsthC}[2][]{\subsubsection[#1]{#2}}
\newcommand{\rsthD}[2][]{\paragraph[#1]{#2}}
\newcommand{\rsthE}[2][]{\paragraph[#1]{#2}}

\newcommand{\rstovA}[2][]{\section*[#1]{#2}}
\newcommand{\rstovB}[2][]{\subsection*[#1]{#2}}
\newcommand{\rstovC}[2][]{\subsubsection*[#1]{#2}}
\newcommand{\rstovD}[2][]{\paragraph*[#1]{#2}}
\newcommand{\rstovE}[2][]{\paragraph*[#1]{#2}}

% Syntax highlighting:
\newcommand{\spanDecNumber}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanBinNumber}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanHexNumber}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanOctNumber}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanFloatNumber}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanIdentifier}[1]{#1}
\newcommand{\spanKeyword}[1]{\textbf{#1}}
\newcommand{\spanStringLit}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanLongStringLit}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanCharLit}[1]{#1}
\newcommand{\spanEscapeSequence}[1]{#1}
\newcommand{\spanOperator}[1]{\textbf{#1}}
\newcommand{\spanPunctuation}[1]{#1}
\newcommand{\spanComment}[1]{\emph{#1}}
\newcommand{\spanLongComment}[1]{\emph{#1}}
\newcommand{\spanRegularExpression}[1]{#1}
\newcommand{\spanTagStart}[1]{#1}
\newcommand{\spanTagEnd}[1]{#1}
\newcommand{\spanKey}[1]{#1}
\newcommand{\spanValue}[1]{#1}
\newcommand{\spanRawData}[1]{\textbf{\textcolor{darkgray}{#1}}}
\newcommand{\spanAssembler}[1]{#1}
\newcommand{\spanPreprocessor}[1]{#1}
\newcommand{\spanDirective}[1]{#1}
\newcommand{\spanCommand}[1]{#1}
\newcommand{\spanRule}[1]{#1}
\newcommand{\spanHyperlink}[1]{#1}
\newcommand{\spanLabel}[1]{#1}
\newcommand{\spanReference}[1]{#1}
\newcommand{\spanOther}[1]{#1}
\newcommand{\spantok}[1]{\fbox{#1}}
\newcommand{\spanPrompt}[1]{\textcolor{red}{\textbf{#1}}}
\newcommand{\spanProgramOutput}[1]{\textcolor{darkgray}{\textbf{#1}}}
\newcommand{\spanprogram}[1]{\textbf{\underline{#1}}}
\newcommand{\spanoption}[1]{\textbf{\textcolor{darkgray}{#1}}}

% Never allow text overflow to margin:
\setlength\emergencystretch{\hsize}\hbadness=10000