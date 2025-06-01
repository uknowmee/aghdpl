%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% File:     aghdpl.cls           (LaTeX Document class option "aghdpl")
%          
% Author:  Marcin Szpyrka     (mszpyrka@agh.edu.pl)
%          Grzegorz J. Nalepa (gjn@agh.edu.pl)
%          Paweł Kłeczek      (p.l.kleczek@gmail.com)
%          AGH University of Science and Technology, Kraków, POLAND
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\message{*** [aghdpl.cls] ---  (MSz, GJN, PK)  v4.0 <29.10.2022>  ***}       

\newif\ifpdflatex\pdflatexfalse
\NeedsTeXFormat{LaTeX2e} % 
\ProvidesClass{aghdpl} 
\DeclareOption{pdflatex}{\pdflatextrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}} 
\ProcessOptions\LoadClass[a4paper,twoside,openright]{report} 

\RequirePackage{times}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage[usenames]{color}
\RequirePackage{fancyhdr}
\RequirePackage{url}
\RequirePackage{titlesec}
\RequirePackage{tocloft}

\RequirePackage[font=small, labelfont=bf, labelsep=period]{caption}
\RequirePackage{subcaption}
\RequirePackage{siunitx}
\RequirePackage{enumerate}
\RequirePackage{enumitem}
\RequirePackage[all,defaultlines=2]{nowidow}

\geometry{lmargin=30mm, rmargin=20mm, tmargin=30mm, bmargin=30mm, foot=10mm, head=10mm}
\definecolor{Green}{rgb}{0.1,0.5,0.1}

\def\shorttitlePL#1   {\gdef\@shorttitlePL{#1}}
\def\shorttitleEN#1   {\gdef\@shorttitleEN{#1}}
\def\shortauthor#1    {\gdef\@shortauthor{#1}}
\def\titlePL#1        {\gdef\@titlePL{#1}}
\def\titleEN#1        {\gdef\@titleEN{#1}}
\def\faculty#1      {\gdef\@faculty{#1}}
\def\thesistype#1   {\gdef\@thesistype{#1}}
\def\supervisor#1   {\gdef\@supervisor{#1}}
\def\acknowledgements#1   {\gdef\@acknowledgements{#1}}
\def\department#1   {\gdef\@department{#1}}
\def\degreeprogramme#1 {\gdef\@degreeprogramme{#1}}


\linespread{1.3}
\renewcommand{\labelitemi}{--}

%------------------------------------------------------------------------------

\def\thesisheaders{
    \fancyfoot[LE,RO]{\small \@shortauthor\quad\textit{\@shorttitlePL}}
}

\def\thesistable{
    \begin{tabular}{p{45mm}l}
    Autor: & {\itshape \@author}\\[-1mm]
    Kierunek studi\'{o}w: & {\itshape \@degreeprogramme}\\[-1mm]
    Opiekun pracy: & {\itshape \@supervisor}\\
    \end{tabular}
}

\DeclareOption{en}{
    \def\thesisheaders{
        \fancyfoot[LE,RO]{\small \@shortauthor\quad\textit{\@shorttitleEN}}
    }
    
    \def\thesistable{
        \begin{tabular}{p{45mm}l}
        Author: & {\itshape \@author}\\[-1mm]
        Degree programme: & {\itshape \@degreeprogramme}\\[-1mm]
        Supervisor: & {\itshape \@supervisor}\\
        \end{tabular}
    }
}

\ProcessOptions

\newcommand{\titlepages}{

    \titlepage
    
    \begin{center}
    \vspace*{1.5cm}
    
    \includegraphics[scale=0.6]{agh.jpg}
    
    \vspace*{2mm}
    {
        \scalebox{0.94}{\sffamily{\large{\bfseries{\scshape Akademia Górniczo-Hutnicza im. Stanisława Staszica w Krakowie}}}}
        
        {\sffamily \fontsize{10.6pt}{12.6pt}\selectfont \bfseries \MakeUppercase{\@faculty}}
    }
    \vspace*{15mm}
    
    {\sffamily\Large \@thesistype}
    \vspace*{7mm}
    
    {\sffamily\Large\itshape \@titlePL}
    \vspace*{2mm}
    
    {\sffamily\Large\itshape \@titleEN}
    \vspace{25mm}
    \end{center}
    
    \noindent
    {\sffamily
    \thesistable
    }
    	
    \vspace*{17mm}
    	
    \centerline{\small\sffamily Kraków, \@date}
    
    \clearpage
    \thispagestyle{empty} 

    {~}\vspace{20mm}
    	
    \clearpage
    \titlepage
    	
    \vspace*{15cm} \vfill
    \begin{flushright} 
        \begin{minipage}[!h]{10cm}
    	{\Large\itshape \@acknowledgements}
        \end{minipage}
    \end{flushright}
    	
    \clearpage
    \thispagestyle{empty}
    	
    ~ \newpage
    	
    \setcounter{page}{5}
}

\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.5pt}
\fancyhf{}
\fancyhead{}
\fancyhead[RE,LO]{\slshape{\small \rightmark}}
\fancyhead[RO,LE]{\bfseries \thepage}

\thesisheaders

\frenchspacing
\sloppy 
\flushbottom

\titleformat{\chapter}[block]
{\bfseries\LARGE}{\filright \LARGE\thechapter. }{0ex}{}
\titlespacing{\chapter}{0pt}{17mm}{19mm}
\titleformat{\section}[block]
{\bfseries\Large}{\filright \Large\thesection. }{0ex}{}
\titlespacing{\section}{7mm}{8mm plus 0mm minus 1mm}{4mm plus 0mm minus 1mm}
\titleformat{\subsection}[block]
{\bfseries\large}{\filright \large\thesubsection. }{0ex}{}
\titlespacing{\subsection}{7mm}{6mm}{2.5mm}
\titleformat{\subsubsection}[block]
{\bfseries\normalsize}{\filright \normalsize\thesubsubsection. }{0ex}{}
\titlespacing{\subsubsection}{7mm}{3mm}{1.5mm}

\renewcommand{\cfttoctitlefont}{\bfseries\Large}
\renewcommand{\cftbeforetoctitleskip}{20mm}
\renewcommand{\cftaftertoctitleskip}{19mm}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdot}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdot}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftdot}}
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\cftsubsecaftersnum}{.}
\setlength{\cftparskip}{2pt}
\setlength{\cftbeforechapskip}{0mm}
\renewcommand{\cftchappagefont}{\normalsize}

\sisetup{
	output-decimal-marker = {,},
	group-separator={~},
}

\renewcommand\UrlFont{\rmfamily\itshape}

\captionsetup[subfigure]{labelfont=md}
\captionsetup{
	subrefformat=parens,
	margin=2cm,
	singlelinecheck=on,
}

\SetLabelAlign{parright}{\parbox[t]{\labelwidth}{\raggedleft#1}}
\setlist[description]{style=multiline, topsep=10pt, align=parright}

\newlength{\descriptiondashgap}
\setlength{\descriptiondashgap}{0.5em}

\renewcommand*\descriptionlabel[1]{\hspace \labelsep \normalfont \bfseries #1 \mdseries\hspace{\descriptiondashgap}--\hspace{\descriptiondashgap}}

\newlength{\eqwheremargin}
\setlength{\eqwheremargin}{2cm}

\newenvironment{eqwhere}[1][]
{
    \setlength{\eqwheremargin}{#1}%
    \begin{description}[leftmargin=\eqwheremargin, itemsep=0cm, labelsep=0cm]
}
{\end{description}}
