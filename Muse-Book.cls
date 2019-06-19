\NeedsTeXFormat{LaTeX2e}

\RequirePackage{ expl3 , xparse, xtemplate, l3keys2e }

\RequirePackage[l2tabu, orthodox]{nag}
\ExplSyntaxOn
\def\IfXeTeXTF#1#2{\csname sys_if_engine_xetex:TF\endcsname{#1}{#2}}

\IfXeTeXTF{
%  \PassOptionsToClass{fontset=none}{ctexbook}
  \PassOptionsToPackage{no-math}{fontspec}
%  \PassOptionsToPackage{utf8}{inputenc}
  }{}

\sys_if_engine_pdftex:TF {
	\PassOptionsToClass{UTF8}{ctexbook}
		\msg_new:nnn { engine } { msg } { Don't~use~pdfLaTeX~to~compile~the~final~TeX~files.}
		\msg_warning:nn { engine } { msg }
} {}


	
	
\ProvidesClass{ Muse-Book }

%\PassOptionsToPackage{subfigure}{tocloft}
%\PassOptionsToPackage{noend}{algpseudocode}
%\PassOptionsToPackage{para}{threeparttable}
\PassOptionsToPackage{sort&compress}{natbib}
\PassOptionsToPackage{newparttoc}{titlesec}
\PassOptionsToPackage{strict}{changepage}

\newif\iffontadvance\fontadvancefalse % for font control

\keys_define:nn { Muse-Book }{
	bibstyle              .choice:                                             ,
	bibstyle              .default:n = super                                   ,
	bibstyle / super      .code:n = \PassOptionsToPackage{super}{gbt7714}      ,
	bibstyle / numbers    .code:n = \PassOptionsToPackage{numbers}{gbt7714}    ,
	bibstyle / authoryear .code:n = \PassOptionsToPackage{authoryear}{gbt7714} ,
	bibstyle / unknown    .code:n = \msg_error:nnxxx { Muse-Book } { unknown-choice } { bibstyle } { super, numbers, authoryear } { The~choice~' #1 '~is~invalid~for~bibstyle	}, 
		
	font           .choice:           ,	
	font           .default:n = empty ,
	font / adobe   .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / fandol  .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / founder .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / none    .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / mac     .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / macnew  .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / macold  .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / windows .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} ,
	font / ubuntu  .code:n = \PassOptionsToClass{fontset = #1}{ctexbook} 
		\msg_new:nnn { ubuntu font } { msg } {
			You~are~using~the~default~fonts,~so~you~better~change~it~by~font=adobe,~or~advance.~If~you~choose~them,~you~should~download~the~necessary~font~and~put~them~in~the~right~palce.
			}
			\msg_warning:nn { ubuntu font } { msg },
	font / advance  .code:n    = \PassOptionsToClass{fontset =none}{ctexbook}
	\fontadvancetrue,
	font / empty    .code:n    = \msg_new:nnn { font } { msg } {
		You~are~using~the~default~fonts,~you~can~change~it~by~font=adobe,~windows,~mac,~advance~and~so~on.
		}
		\msg_warning:nn { font } { msg },
	font / unknown  .code:n = \msg_error:nnxxx { Muse-Book } { unknown-choice }
	{ font }{ empty, adobe, fandol, founder, mac, macnew, macold, ubuntu, windows, advance }{ The~choice~' #1 '~is~invalid~for~font },
}

\ProcessKeysOptions { Muse-Book }


\LoadClass [ 10pt, openany,  ] {ctexbook} % twoside,

\sys_if_engine_pdftex:TF {\RequirePackage{microtype,amsfonts}} {}


\RequirePackage
  {
    amsmath        ,
    amsthm         ,
    amssymb        ,
    physics        ,
    siunitx        ,
    noto           ,%
    verbatim       ,
%    multirow       ,
    geometry       ,
    changepage     ,
    fancyhdr       ,
%    footmisc       ,
    graphicx       ,
%    dblfloatfix    ,
%    longtable      ,
%    booktabs       ,
%    tabularx       ,
    caption        ,
%    threeparttable ,
%    subfig         ,
%    tocloft        ,
    etoc           ,
    titlesec       ,
%    everypage      ,
    calc           ,
    tikz           ,
    tcolorbox      ,
    varwidth       ,
    }
\RequirePackage
  {
%    listings       ,
    setspace       ,
%    pifont         ,
    float          ,
    gbt7714        ,
%    natbib        ,
    hyperref       ,
%    algorithm      ,
%    algpseudocode  ,
    cleveref       ,
   }
  
\IfXeTeXTF{
\RequirePackage{unicode-math}
%\setmainfont{Times~New~Roman}  % Times~New~Roman  Source~Serif~Pro
%\setsansfont{Arial}            % Arial  Source~Sans~Pro

\unimathsetup{
  math-style = ISO     ,
  bold-style = ISO     ,
  nabla      = upright ,
  partial    = upright ,
  }
}{}

\geometry{	
	left   = 2cm ,
	right  = 2cm ,
	top    = 3cm ,
	bottom = 3cm ,
	}  
\captionsetup{font={small,bf}}
\hypersetup{
%	bookmarks=true            ,
	bookmarksnumbered = false ,
	linkcolor         = black ,
	citecolor         = blue  ,
	urlcolor          = green ,
	colorlinks                ,
	}

  
\keys_if_exist:nnTF { Muse-Book } { bibstyle } { 
	\RequirePackage[sort&compress]{natbib}
	\RequirePackage{gbt7714} 
	} { }

\iffontadvance


%	  \setmonofont[
%	    Extension          = .otf      ,
%		Path               = fonts/    ,
%		UprightFont        = *-regular ,
%	    BoldFont           = *-bold    ,
%	    ItalicFont         = *-it      ,
%	    BoldItalicFont     = *-boldit] {SourceCodePro}	
	  \setCJKmainfont[
		Extension          = .otf      ,
	    Path               = fonts/    ,
	    UprightFont        = *-Regular ,
	    BoldFont           = *-Bold    ,
	    ItalicFont         = *-Regular ,
	    BoldItalicFont     = *-Bold    ,
	    ItalicFeatures     = FakeSlant ,
	    BoldItalicFeatures = FakeSlant] {NotoSerifCJKsc}
	  \setCJKsansfont[
		Extension          = .otf      ,
	    Path               = fonts/    ,
	    UprightFont        = *-Regular ,
	    BoldFont           = *-Bold    ,
	    ItalicFont         = *-Regular ,
	    BoldItalicFont     = *-Bold    ,
	    ItalicFeatures     = FakeSlant ,
	    BoldItalicFeatures = FakeSlant] {NotoSansCJKsc}
	  \setCJKmonofont[
		Extension          = .otf      ,
	    Path               = fonts/    ,
	    UprightFont        = *-Regular ,
	    BoldFont           = *-Bold    ,
	    ItalicFont         = *-Regular ,
	    BoldItalicFont     = *-Bold    ,
	    ItalicFeatures     = FakeSlant ,
	    BoldItalicFeatures = FakeSlant] {NotoSansMonoCJKsc}  
	  \setmathfont[
	    Extension    	   = .otf          ,
	    Path               = fonts/        ,
	    BoldFont           = XITSMath-Bold ,
	    StylisticSet       = 8] {XITSMath-Regular}


\fi 
\ExplSyntaxOff

\graphicspath{{Figures/},{../Figures/}, } %设定图片的存放路径

\newenvironment{rpg-list}{ 
    \begin{list}{\includegraphics[scale=0.4]{lib/book/img/weapons.png}}{}
}{
	\end{list}
}

\definecolor{pagegold}{HTML}{B89A67}  % pagenumbers and footer
\definecolor{title1}{HTML}{58180D}	% e.g. used for titles
\definecolor{title2}{HTML}{0d2b58}	% e.g. used for titles
\definecolor{title3}{HTML}{58390d}	% e.g. used for titles
\definecolor{rulered}{HTML}{9C2B1B}		%e.g. used for triangular rule in statsblock
\definecolor{undergold}{HTML}{C9AD6A}	% e.g. used for titlerules
\definecolor{bgquote}{HTML}{F7F2E5}
\definecolor{monstertandark}{HTML}{F0DBB5}
\definecolor{museblue}{HTML}{D2E9F8}
%for bash
\definecolor{cf06678}{RGB}{240,102,120}
\definecolor{c7dcd5a}{RGB}{125,205,90}
\definecolor{cf3d96c}{RGB}{243,217,108}
\definecolor{c7da7de}{RGB}{125,167,222}


% Setup for custom footer
\pagestyle{fancy}

\newlength{\nobgfooterheight}
\setlength{\nobgfooterheight}{\paperheight}
\addtolength{\nobgfooterheight}{-1in}
\addtolength{\nobgfooterheight}{-\topmargin}
\addtolength{\nobgfooterheight}{-\headheight}
\addtolength{\nobgfooterheight}{-\headsep}
\addtolength{\nobgfooterheight}{-\textheight}
\addtolength{\nobgfooterheight}{-\footskip}

\renewcommand{\headrulewidth}{0.0pt} %no rule for header
\renewcommand{\footrulewidth}{0.0pt} %no rule for footer

\fancyhf{} % clear all headers and footers

\fancyhead{
    \begin{tikzpicture}[remember picture,overlay]
        \node[inner sep=0pt] at (current page.center) {\includegraphics[width=\paperwidth,height=\paperheight]{lib/book/img/background}};
    \end{tikzpicture}
}

\fancyfoot[LE]{
    \begin{tikzpicture}[remember picture,overlay]
        \node[xscale=-1,inner sep=0pt,anchor=south,nearly opaque] at (current page.south) {\includegraphics[width=\paperwidth,height=43pt]{lib/book/img/footerscroll}};
        \node[xshift=20pt,yshift=30pt] at (current page.south west) {\textcolor{pagegold}{\thepage}};
        \node[anchor=south west,xshift=\marginparwidth+\marginparpush,yshift=27pt] at (current page.south west) {\textcolor{pagegold}{\nouppercase\leftmark}};
    \end{tikzpicture}
}

\fancyfoot[RO]{
    \begin{tikzpicture}[remember picture,overlay]
        \node[inner sep=0pt,anchor=south,nearly opaque] at (current page.south) {\includegraphics[width=\paperwidth,height=43pt]{lib/book/img/footerscroll}};
        \node[xshift=-20pt,yshift=30pt] at (current page.south east) {\textcolor{pagegold}{\thepage}};
        \node[anchor=south east,xshift=-\marginparwidth-\marginparpush,yshift=27pt] at (current page.south east) {\textcolor{pagegold}{\nouppercase\leftmark}};
    \end{tikzpicture}
}

\fancypagestyle{plain}{}


\fancypagestyle{part}{
    \fancyhf{} % clear all headers and footers
    \fancyhead{
        \begin{tikzpicture}[remember picture,overlay]
            \node[inner sep=0pt] at (current page.center) {\includegraphics[width=\paperwidth,height=\paperheight]{lib/book/img/part-cover}};
            \node[inner sep=0pt,anchor=north] at (current page.north) {\includegraphics[width=\paperwidth]{lib/book/img/header-part-circ}};
            \node[inner sep=0pt,anchor=north west] at (current page.north west) {\includegraphics[width=.5\paperwidth]{lib/book/img/header-part}};
            \node[xscale=-1, inner sep=0pt, anchor=north west] at (current page.north east) {\includegraphics[width=.5\paperwidth]{lib/book/img/header-part}};
        \end{tikzpicture}
    }
}

\fancypagestyle{chapter}{
    \thispagestyle{fancy}
    \fancyhead{
        \begin{tikzpicture}[remember picture,overlay]
            \node[inner sep=0pt] at (current page.center) {\includegraphics[width=\paperwidth,height=\paperheight]{lib/book/img/background}};
            \node[inner sep=0pt,anchor=north west] at (current page.north west) {\includegraphics[width=.5\paperwidth]{lib/book/img/header-chapter}};
            \node[xscale=-1, inner sep=0pt, anchor=north west] at (current page.north east) {\includegraphics[width=.5\paperwidth]{lib/book/img/header-chapter}};
        \end{tikzpicture}
    }
}


% cover
\ExplSyntaxOn
\tl_new:N \l__muse_cover_image_tl
\tl_new:N \l__muse_cover_logo_tl
\tl_new:N \l__muse_cover_title_tl
\tl_new:N \l__muse_cover_subtitle_tl
\keys_define:nn { muse-book }
{
  image     .tl_set:N  = \l__muse_cover_image_tl    ,
  logo      .tl_set:N  = \l__muse_cover_logo_tl     ,
  title     .tl_set:N  = \l__muse_cover_title_tl    ,
  subtitle  .tl_set:N  = \l__muse_cover_subtitle_tl ,
}
%art
\DeclareDocumentCommand \musecover { m }
{
\group_begin:
\keys_set:nn { muse-book } { #1 }{
%    \onecolumn
    \thispagestyle{empty}
	\tikz[remember~picture,overlay] \node[opacity=1,inner~sep=0pt] at (current~page.center){\includegraphics[width=\paperwidth,height=\paperheight]{\l__muse_cover_image_tl}};%,height=6cm
    \begin{center}    
        \includegraphics[width=3cm]{\l__muse_cover_logo_tl}\par
        \fontsize{48pt}{48pt}\selectfont \textcolor{white}{\MakeUppercase{\l__muse_cover_title_tl}}\par
        \includegraphics[width=.5\paperwidth]{lib/book/img/separator}
        \vfill    
        \fontsize{18pt}{18pt}\selectfont\textcolor{white}{\textbf{\l__muse_cover_subtitle_tl}}
    \end{center}
    \clearpage
%    \twocolumn%
}
\group_end:
}
\keys_set:nn { muse-book } { 
  image=img/cover,
  logo=img/logo,
  title=Muse-Book~based~on~Rpg~Template,
  subtitle=Created by Camuse , }
%\ProcessKeysOptions { Muse-book }
\ExplSyntaxOff

\newlength{\rpghmargin}
\DeclareDocumentCommand\museart{ s O{t} m g }{%
	\IfBooleanTF {#1}{%
	\IfNoValueTF {#4}{
	\if #2t 
		\tikz[remember picture,overlay] \node[opacity=0.7,inner sep=0pt] at (current page.north){\includegraphics[width=\paperwidth,height=8cm]{#3}};% 
	\fi 
	\if #2b 
		\tikz[remember picture,overlay] \node[opacity=1,inner sep=0pt] at (current page.south){\includegraphics[width=\paperwidth,height=8cm]{#3}};% 
	\fi 
			}{
	\if #2t 
		\tikz[remember picture,overlay] \node[opacity=#4,inner sep=0pt] at (current page.north){\includegraphics[width=\paperwidth,height=8cm]{#3}};% 
	\fi 
	\if #2b 
		\tikz[remember picture,overlay] \node[opacity=#4,inner sep=0pt] at (current page.south){\includegraphics[width=\paperwidth,height=8cm]{#3}};% 
	\fi 
			}
	}{
	\IfNoValueTF {#4}{ }{ }  
    \checkoddpage
    \ifoddpage
        \setlength{\rpghmargin}{\dimexpr1in+\hoffset+\oddsidemargin+4pt \relax}
        %
    \else
        \setlength{\rpghmargin}{\dimexpr1in+\hoffset+\evensidemargin+4pt \relax}
    \fi
    \begin{figure*}[#2!]
        \centering
        \if #2t
            \vspace*{-\dimexpr1in+\voffset+\topmargin+\headheight+\headsep\relax}%
        \fi
         \rlap{\makebox[\paperwidth][l]{%
            \hskip-\rpghmargin \relax
            \includegraphics[width=\paperwidth-0.5pt]{#3}%-1pt
        	}
        }
        \if #2b
            \vspace*{-\dimexpr\paperheight-\textheight-1in+13pt-\voffset-\topmargin-\headheight-\headsep\relax}%
        \fi
    \end{figure*}
	}
}

%目录
\renewcommand\thepart{第~\zhnumber{\arabic{part}}~卷}%\arabic
\titleformat{\part}
[display]
{\thispagestyle{part}%\nodesto\fontsize{150pt}{50pt}
\fontsize{30}{50}\selectfont\color{title1}\filcenter}%\selectfont
{\thepart}%\partname~
{-15pt}
{\fontsize{20}{30}\selectfont}%\Large

\titlespacing*{\part}{0pt}{-120pt}{0pt}

%\renewcommand\cftpartpresnum{第~}
\ctexset{part={
name={第,卷},
number=\zhnumber{\arabic{part}},
%format = \sffamily\bfseries\centering\Large,
},
%contentsname ={\Huge\sffamily\bfseries \textcolor{pagegold}{目~录}}
}

\newcommand*{\DotsAndPage}
{\nobreak\leaders\hbox{\normalsize\hbox to 2ex {\hss.\hss}}%
\hfill~\nobreak
\makebox[\rightskip][r]{~\normalsize\etocpage}\par}

\etocsetstyle {part}
{\parindent 0pt \nobreak}
{{\pagebreak[3]\bigskip}}
{\centering\sffamily\huge\textcolor{white}{\hrulefill}\makebox[2.5cm][l]{~\etocnumber}\sffamily\etocname~\textcolor{white}{\hrulefill}\nobreak\par}%
{\relax}

\etocsetstyle {chapter}
{}
{\pagebreak[1]\smallskip}
{\sffamily\Large\makebox[1.6cm][l]{\etocnumber}%
\etocname\nobreak\DotsAndPage\nobreak\par}
{}

\etocsetstyle {section}
{}
{\leftskip 1.7cm\pagebreak[1]\smallskip}
{\sffamily\large\makebox[0.75cm][l]{\etocnumber}%
\etocname\nobreak\DotsAndPage\nobreak\par}
{}

\etocsetstyle {subsection}
{}
{\leftskip 2.3cm\nobreak\smallskip}
{\mdseries\normalsize\makebox[1cm][l]{\etocnumber}%
\etocname\nobreak\DotsAndPage\nobreak\par}
{}

\etocsetstyle {subsubsection}
{}
{\leavevmode\leftskip 2.5cm\relax }
{\mdseries\normalsize\makebox[1cm][l]{\etocnumber}%
\etocname\nobreak\DotsAndPage\nobreak\par}
{}
\etocruledstyle[1]{{\centering\Huge\sffamily\bfseries \textcolor{pagegold}{目~录~}}}
%\tableofcontents 




%%%%%%%%%%%%%% \chapter

\titleformat{\chapter}
[display]
{\thispagestyle{chapter}\vspace{-100pt}\color{title1}}%\rpg@TitleFont
{\flushright \normalsize \color{title1} 
{\fontsize{40}{60}\selectfont \color{title1}\CTEXthechapter }}%\MakeUppercase{\chaptertitlename}
{0em}
{\Huge}
[{\titleline{\color{undergold}\titlerule[2pt]}}]

%%%%%%%%%%%%%% \section

\titleformat{\section}%[block]
{\color{title1}\huge}{\thesection}{0.5em}{}%\rpg@TitleFont
[{\titleline{\color{undergold}\titlerule[0.5pt]}}]

%%%%%%%%%%%%%% \subsection


\titleformat{\subsection}%[block]
{\color{title2}\LARGE}{\thesubsection}{0.5em}{\resizebox{1.5ex}{!}{$\star$} }% \bigstar
[{\titleline{\color{title2}\titlerule[0.5pt]}}]

%%%%%%%%%%%%%% \subsubsection

\titleformat{\subsubsection}
{\color{title3}\Large}{\thesubsubsection}{0em}{$\blacktriangleright$ }[]%\rpg@TitleFont



%\def\lstbasicfont{\fontfamily{pcr}\selectfont\footnotesize}%
%\lstset{%
%	numbers=left,
%	numberstyle=\tiny,
%	basicstyle=\small,
%	backgroundcolor=\color{white},      % choose the background color
%	basicstyle=\footnotesize\ttfamily,  % size of fonts used for the code
%	columns=fullflexible,
%	tabsize=4,
%	breaklines=true,               % automatic line breaking only at whitespace
%	captionpos=b,                  % sets the caption-position to bottom
%	commentstyle=\color{green},  % comment style
%	escapeinside={\%*}{*)},        % if you want to add LaTeX within your code
%	keywordstyle=\color{blue},     % keyword style
%	stringstyle=\color{purple}\ttfamily,  % string literal style
%	frame=single,
%	rulesepcolor=\color{red!20!green!20!blue!20},
%}
%\lstloadlanguages{C,C++,Java,Matlab,Mathematica}  % supported languages



\renewcommand{\citep}[1]{{\color{blue}\citeauthor{#1}(\citeyearpar{#1})}}
\crefformat{figure}{#2图#1#3}
\crefrangeformat{figure}{图(#3#1#4)\;$\sim$\;(#5#2#6)}
\crefmultiformat{figure}{图~(#2#1#3)}{和~(#2#1#3)}{，(#2#1#3)}{和~(#2#1#3)}

\crefformat{table}{#2表#1#3}
\crefrangeformat{table}{表(#3#1#4)\;$\sim$\;(#5#2#6)}
\crefmultiformat{table}{表~(#2#1#3)}{和~(#2#1#3)}{，(#2#1#3)}{和~(#2#1#3)}

\crefformat{equation}{~(#2#1#3)}
\crefrangeformat{equation}{~(#3#1#4)\;$\sim$\;(#5#2#6)}
\crefmultiformat{equation}{~(#2#1#3)}{ 和~(#2#1#3)}{，(#2#1#3)}{ 和~(#2#1#3)}



%box
\usetikzlibrary{decorations.pathmorphing}
\tcbuselibrary{listings,skins,xparse}


\NewDocumentCommand\gitbash{O{1}} {
\begin{tikzpicture}[y=0.80pt, x=0.80pt, yscale=-#1, xscale=#1, inner sep=0pt, outer sep=0pt]
\begin{scope}[shift={(5.29167,17.3869)}]% layer1-0
  \begin{scope}[cm={{0.35278,0.0,0.0,-0.35278,(60.67778,193.98889)}}]% g18
    \begin{scope}[scale=0.100]% g20
      % path22
      \path[fill=cf06678,nonzero rule] (1370.0000,1601.6600) -- (1370.0000,1438.3300)
        -- (1459.1700,1525.8300) -- cycle;
      % path24
      \path[fill=cf06678,nonzero rule] (1470.0000,1743.3400) .. controls
        (1492.0700,1816.8100) and (1469.3900,1896.1500) .. (1412.5000,1945.0000) ..
        controls (1360.9100,1989.3000) and (1288.5400,2002.2200) ..
        (1223.3300,1979.1600) -- (925.0000,2284.1600) -- (1220.8300,2560.0000) --
        (1331.6700,2560.0000) -- (1918.3300,1990.8400) -- (1567.5000,1639.1600) --
        (1470.0000,1743.3400);
      % path26
      \path[fill=cf06678,nonzero rule] (1215.8300,1618.3400) .. controls
        (1194.8400,1626.3700) and (1170.2900,1639.5700) .. (1148.3300,1661.6600) ..
        controls (1068.0200,1742.4800) and (1095.2000,1868.9300) ..
        (1098.3300,1882.5000) -- (812.5000,2170.8400) -- (625.8280,1977.5000) --
        (1211.6700,1413.3300) -- (1215.8300,1618.3400);
      % path28
      \path[fill=c7dcd5a,nonzero rule] (1635.8300,1345.8300) .. controls
        (1633.9200,1340.5700) and (1595.1200,1228.4400) .. (1667.5000,1141.6700) ..
        controls (1718.2400,1080.8400) and (1789.3900,1073.5000) ..
        (1800.8300,1072.5000) .. controls (1809.9100,1071.7100) and
        (1895.8700,1065.6400) .. (1957.5000,1130.0000) .. controls
        (1988.8000,1162.6900) and (1999.1200,1198.1700) .. (2003.3300,1213.3300) ..
        controls (2006.8500,1225.9700) and (2028.5000,1308.5900) ..
        (1983.3300,1377.5000) .. controls (1939.3000,1444.6800) and
        (1846.6200,1476.1400) .. (1754.1700,1452.5000) -- (1623.7400,1579.1700) --
        (1981.6700,1929.1600) -- (2560.0000,1337.5000) -- (2560.0000,1218.3300) --
        (1989.1700,635.8280) -- (1418.3300,1199.1700) .. controls
        (1382.6800,1253.5300) and (1376.0400,1305.6900) .. (1407.5000,1355.0000) --
        (1515.0000,1469.1700) -- (1635.8300,1345.8300);
      % path30
      \path[fill=cf3d96c,nonzero rule] (1216.8200,920.0000) .. controls
        (1115.1200,862.5510) and (1075.4000,743.7810) .. (1115.9900,653.3280) ..
        controls (1146.1200,586.1480) and (1218.3800,539.5120) .. (1297.6500,540.8280)
        .. controls (1377.5900,542.1720) and (1449.0200,592.0200) ..
        (1476.8200,662.5000) .. controls (1512.1200,752.0120) and (1472.1500,862.4690)
        .. (1377.6500,915.8280) -- (1383.4900,1124.1700) -- (1927.6500,575.0000) --
        (1354.3200,0.0000) -- (1239.3200,0.0000) -- (625.1450,597.5000) --
        (1220.9900,1170.8300) -- (1216.8200,920.0000);
      % path32
      \path[fill=c7da7de,nonzero rule] (560.8280,653.3280) -- (1129.1700,1218.3300) --
        (1129.1700,1360.0000) -- (569.1720,1929.1600) -- (0.0000,1359.1700) --
        (0.0000,1225.8300) -- (560.8280,653.3280);
    \end{scope}
  \end{scope}
\end{scope}
\end{tikzpicture}
}

\NewTColorBox{muse-ordinary-box}{ O{} m }{
	boxrule=1pt,
	toptitle=2mm,
	bottomtitle=2mm,
	left=8pt,
	right=8pt,
	arc=0mm,
	fonttitle=\centering\bfseries\color{black},
	fontupper=\rmfamily,
    title=#1,
    colback={#2!75!white},
    colframe={#2!75!black},
	colbacktitle=musecolor,
    opacityback=0.5
}

\NewDocumentEnvironment{muse-obox}{og}{
	\IfNoValueTF{#1}{\IfNoValueTF{#2}{ 
		\definecolor{musecolor}{HTML}{D2E9F8}
			\begin{muse-ordinary-box}[盒子]{musecolor}
			}{
		\definecolor{musecolor}{rgb}{#2}
			\begin{muse-ordinary-box}[盒子]{musecolor} 
			} 
		}
	{\IfNoValueTF{#2}{ 
		\definecolor{musecolor}{HTML}{D2E9F8}
			\begin{muse-ordinary-box}[#1]{musecolor}
			}{
		\definecolor{musecolor}{rgb}{#2}
			\begin{muse-ordinary-box}[#1]{musecolor}
			}
		}
	}
{\end{muse-ordinary-box}}

\NewTColorBox{muse-titlebox}{ O{} m }{%
    title=#2,left=1mm,right=1mm,enhanced,
    attach boxed title to top center={yshift=-0.25mm-\tcboxedtitleheight/2,yshifttext=2mm-\tcboxedtitleheight/2},
    boxed title style={
        boxrule=0.5mm,
        frame code={
            \path[tcb fill frame] ([xshift=-4mm]frame.west)
            -- (frame.north west) -- (frame.north east) -- ([xshift=4mm]frame.east)
            -- (frame.south east) -- (frame.south west) -- cycle;
        },
        interior code={
            \path[tcb fill interior] ([xshift=-2mm]interior.west)
            -- (interior.north west) -- (interior.north east)
            -- ([xshift=2mm]interior.east) -- (interior.south east) -- (interior.south west)
            -- cycle;
        }
    },
    #1
}

\NewTColorBox{muse-pbox}{ O{} m }{enhanced,fonttitle=\bfseries\textcolor{black},title style image=blueshade.png,
title={#2},#1}

\NewTColorBox{muse-quotebox}{ O{} m }{%
enhanced jigsaw,frame hidden,boxrule=0pt,
	enhanced,toptitle=3mm,boxsep=0.25ex,left=8pt,right=8pt,
	colback=bgquote,
	colframe=bgquote,
	colbacktitle=bgquote,
	arc=0mm,
	fonttitle=\bfseries,
	borderline west={1pt}{-0.5pt}{title1},
	borderline east={1pt}{-0.5pt}{title1},
	fontupper=\rmfamily,
	%title=#2,
	overlay={
		\foreach \n in {north east,north west,south east,south west}
		{\draw [title1, fill=title1] (frame.\n) circle (2pt); } },%;
	after={\vspace{5pt plus 1pt}\noindent}
}

\newtoks\musetheorem
\newtoks\musedefinition
\newtoks\museproposition
\newtoks\museexample
\newtoks\muselisting
\newtoks\musecmd
\musetheorem{定理}
\musedefinition{定义}
\museproposition{命题}
\museexample{例子}
\muselisting{Listing}
\musecmd{Shell}
\crefformat{tcb@cnt@muse-theorem}{#2\the\musetheorem~#1#3}
\crefformat{tcb@cnt@muse-definition}{#2\the\musedefinition~#1#3}
\crefformat{tcb@cnt@muse-proposition}{#2\the\museproposition~#1#3}
\crefformat{tcb@cnt@muse-example}{#2\the\museexample~#1#3}
\crefformat{tcb@cnt@muse-listing}{#2\the\muselisting~#1#3}
\crefformat{tcb@cnt@muse-cmd}{#2\the\musecmd~#1#3}

\NewTColorBox[auto counter,number within=section]{muse-example}{ O{} m g }{
	enhanced,before skip=11pt plus 1pt,toptitle=3mm,boxsep=0.25ex,
	left=8pt,right=8pt,fonttitle=\bfseries\color{black},fontupper=\rmfamily,
	title={\the\museexample~\thetcbcounter: #2},
	arc=0mm,
	borderline north={1pt}{-0.5pt}{black},
	borderline south={1pt}{-0.5pt}{black},
	colback=monstertandark,
	colframe=monstertandark,
	colbacktitle=monstertandark,
	fuzzy shadow={0mm}{-3.5pt}{-0.5pt}{0.4mm}{black!60!white},
	overlay={
		\fill [fill=black] (frame.south west) -- ++(7pt,0) -- ++(0,-5pt) -- cycle;
		\fill [fill=black] (frame.north west) -- ++(7pt,0) -- ++(0,5pt) -- cycle;
		\fill [fill=black] (frame.north east) -- ++(-7pt,0) -- ++(0,5pt) -- cycle;
		\fill [fill=black] (frame.south east) -- ++(-7pt,0) -- ++(0,-5pt) -- cycle;
		},
	after={\vspace{10pt plus 1pt}\noindent},
	IfNoValueTF={#3}
	{label={exa:\thetcbcounter}}{label={#3}},#1,
}

\NewTColorBox[auto counter,number within=section,%number format=\Alph
]{muse-theorem}{ O{} m g }{%
enhanced,
colframe=pink!50!black,colback=pink!10!white,
arc=1mm,colbacktitle=red!10!white,
fonttitle=\bfseries,coltitle=red!50!black,
attach boxed title to top left=
{xshift=3mm,yshift=-0.50mm},
boxed title style={skin=enhancedfirst jigsaw,
size=small,arc=1mm,bottom=-1mm,
interior style={fill=none,
top color=orange!50!white,
bottom color=orange!20!white}},
title={\the\musetheorem~\thetcbcounter: #2},#1,
IfNoValueTF={#3}
{label={thm:\thetcbcounter}}{label={#3}},
}

\NewTColorBox[auto counter,number within=section,%number format=\Alph
]{muse-definition}{ O{} m g }{%
enhanced,
attach boxed title to top left={xshift=-4mm%xshift=1cm
,yshift=-2mm},
fonttitle=\sffamily,varwidth boxed title=0.7\linewidth,
colbacktitle=green!45!white,coltitle=green!10!black,colframe=green!50!black,
interior style={top color=yellow!10!white,bottom color=green!10!white},
boxed title style={boxrule=0.75mm,colframe=white,
borderline={0.1mm}{0mm}{green!50!black},
borderline={0.1mm}{0.75mm}{green!50!black},
interior style={top color=green!10!white,bottom color=green!10!white,
middle color=green!50!white},
drop fuzzy shadow},
title={\the\musedefinition~\thetcbcounter: #2},#1,
IfNoValueTF={#3}
{label={def:\thetcbcounter}}{label={#3}},
}

\NewTColorBox[auto counter,number within=section,%number format=\Alph
]{muse-proposition}{ O{} m g }{%
enhanced,skin=enhancedlast jigsaw,
attach boxed title to top left={xshift=-4mm,yshift=-0.5mm},
fonttitle=\sffamily,varwidth boxed title=0.7\linewidth,
colbacktitle=blue!45!white,colframe=red!50!black,
interior style={top color=blue!10!white,bottom color=red!10!white},
boxed title style={empty,arc=0pt,outer arc=0pt,boxrule=0pt},
underlay boxed title={
\fill[blue!45!white] (title.north west) -- (title.north east)
-- +(\tcboxedtitleheight-1mm,-\tcboxedtitleheight+1mm)
-- ([xshift=4mm,yshift=0.5mm]frame.north east) -- +(0mm,-1mm)
-- (title.south west) -- cycle;
\fill[blue!45!white!50!black] ([yshift=-0.5mm]frame.north west)
-- +(-0.4,0) -- +(0,-0.3) -- cycle;
\fill[blue!45!white!50!black] ([yshift=-0.5mm]frame.north east)
-- +(0,-0.3) -- +(0.4,0) -- cycle; },
title={\the\museproposition~\thetcbcounter: #2},#1,
IfNoValueTF={#3}
{label={pro:\thetcbcounter}}{label={#3}},
}

\DeclareTCBListing[auto counter,number within=section]{muse-listing}{ s O{} m g }{%
skin=enhanced,fonttitle=\sffamily,boxrule=1mm,
frame style={draw=blue,fill=cyan},drop fuzzy shadow,
interior style={draw=green,top color=museblue!10,bottom color=museblue!20},
segmentation style={draw=black,solid,decorate,
decoration={coil,aspect=0,segment length=10.1mm}},
IfBooleanTF={#1}
{listing side text}
{text side listing},IfNoValueTF={#4}
{label={lis:\thetcbcounter}}{label={#4}},
title={\the\muselisting~\thetcbcounter: #3},#2,
  listing options={
    basicstyle=\footnotesize\ttfamily,
    keywordstyle=\color{blue}\ttfamily,
    stringstyle=\color{red}\ttfamily,
    commentstyle=\color{green}\ttfamily,
    breaklines=true,
    showstringspaces=false,
    tabsize=2,
    numbers=left
  },
}

\DeclareTCBListing[use counter from=muse-listing]{muse-hlisting}{ O{} m g }{
  title={\the\muselisting~\thetcbcounter: #2},
skin=enhanced,fonttitle=\sffamily,boxrule=1mm,
frame style={draw=blue,fill=cyan},drop fuzzy shadow,
interior style={draw=blue,top color=blue!10,bottom color=blue!20},
segmentation style={draw=green,solid,decorate,
decoration={coil,aspect=0,segment length=10.1mm}},
  listing options={
    basicstyle=\footnotesize\ttfamily,
    keywordstyle=\color{blue}\ttfamily,
    stringstyle=\color{red}\ttfamily,
    commentstyle=\color{green}\ttfamily,
    breaklines=true,
    showstringspaces=false,
    tabsize=2,
    numbers=left
  },#1,IfNoValueTF={#3}
  {label={lis:\thetcbcounter}}{label={#3}},
  overlay={
    \fill[gray!10] %gray!30
      ([xshift=-2.5pt]frame.south west)
      rectangle 
      ([xshift=10pt]frame.north west);
  }
}

%\includegraphics[scale=0.04]{img/git.png}
\DeclareTCBListing[auto counter,number within=section]{muse-cmd}{ O{root} m g }{%
colback=black,colupper=white,colframe=gray!75!black,
listing only,listing options={style=tcblatex,language=sh},
every listing line={\textcolor{green}{\small\ttfamily\bfseries #1 \$$ > $ }},
IfNoValueTF={#3}
{label={cmd:\thetcbcounter}}{label={#3}},
title={\hspace*{-1ex}\gitbash[0.15]~~\the\musecmd~\thetcbcounter: #2},
}