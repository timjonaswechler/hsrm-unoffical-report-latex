\NeedsTeXFormat{LaTeX2e}
\LoadClass[%
	  paper=A4,               							% Dokumentengröße
	  %twoside,           								% Einseitig oder Zweiseitig (oneside/twoside)
	%   openright,                						% doublepage cleaning ends up right side
	  parskip=half,           							% spacing value / method for paragraphs
	  %chapterprefix=true,     							% prefix for chapter marks
	  12pt,                   							% Schriftgröße
	  headings=normal,        							% size of headings
	  bibliography=totoc,     							% include bib in toc
	  listof=totoc,           							% include listof entries in toc
	  titlepage=on,           							% own page for each title page
	  captions=tableabove,    							% display table captions above the float env
	  chapterprefix=false,    							% do not display a prefix for chapters
	  appendixprefix=false,   							% but display a prefix for appendix chapter
	  draft=false,            							% value for draft version
	  numbers=noenddot
	]{scrreprt}
	\ProvidesClass{.src/hsrmreport}[2022/05/25 Klassen fuer die Erstellung von Berichten an der Hochschule RheinMain]

	% **************************************************
	% Optionen  (https://www.namsu.de/Extra/latex-pakete.html)
	% **************************************************
		\RequirePackage{expl3}							% LaTeX3 Packet
		\RequirePackage{xpatch}							%
		\RequirePackage{xkeyval}						%
		\RequirePackage{xifthen}						% Für die Möglichkeit If-Abfragen zu erstellen (http://ctan.ebinger.cc/tex-archive/macros/latex/contrib/xifthen/xifthen.pdf)
		\RequirePackage{kvoptions} 						% http://www.tug.org/tugboat/tb30-1/tb94wright-keyval.pdf
		\SetupKeyvalOptions{							%
			family=hsrm,								%
			prefix=hsrm@								%
		}
		% **********************************************
		% Definition aller Optionen 
		% **********************************************
			%  ---  mögliche Optionen:
			% 		[para name](bool) lua 			> default = false
			% 		[para name](string) path 		> default = .
			% 		[para name](bool) thesis 		> default = false
			% 		[para name](bool) section 		> default = false
			% 		[para name](bool) sperrvermerk 	> default = false
			% 		[para name](bool) eigenstaendigkeit > default = true
			% 		[para name](bool) banner 		> default = true
			% 		[para name](bool) backgroundlogo > default = true
			% 		[para name](bool) coloredheadline > default = false
			% 		[para name](bool) flama 		> default = false
			% 		[para name](bool) georgia 		> default = false
			% 		[para name](bool) svg 			> default = false
			% 		[para name](bool) listingsforcontent > default = false
			%		[para name](bool) toc 			> default = true
			% 		[para name](bool) lof 			> default = false
			%		[para name](bool) lot 			> default = false
			% 		[para name](bool) lol 			> default = false
			%		[para name](string) bibfile 	> default = bib-refs
			%		[para name](string) bibstyle 	> default = alphabetic
			% 		[para name](bool) printbib 		> default = false
			%		[para name](bool) emoji 		> default = false
			%
			%  ---  Beschreibung der Optionen:
			% 		[lua] 			
			% 		[path] 			
			% 		[thesis] 		Ändert das Dokument so ab, dass die PDFs für einen Buchdruck ausgerichtet werden.
			%						Der Name der Option ist aus der Ursprünglichen Dokumentenklasse und kann auch geändert werden.
			%						z.B. towside
			% 		[section] 		Schält die Nummerierung um. Es werden die Kapitelnummern ignoriert.
			%						Anwendung wenn, ein kleines Dokument erstellt wird, in dem nicht viele Kapitel sind oder diese nicht sonderlich groß sind.
			% 		[sperrvermerk] 	
			% 		[eigenstaendigkeit] 
			% 		[banner] 		
			% 		[backgroundlogo] 
			% 		[coloredheadline]
			% 		[flama] 	
			% 		[georgia] 	
			% 		[svg] 		
			% 		[listingsforcontent] 
			%		[toc] 			Ermöglicht es das Inhaltsverzeichnis aus zu blenden.
			% 		[lof] 			Ermöglicht es das Abbildungsverzeichnis einzublenden.
			%		[lot] 			Ermöglicht es das Tabellenverzeichnis einzublenden.
			% 		[lol] 			Ermöglicht es das Programmcodeverzeichnis einzublende.
			%		[bibfile] 		Gibt den Name der Bibliothek an die Standardmäßig eingebunden ist.
			%		[bibstyle] 		Nach welchem Stil das Literaturverzeichnis aufgebaut werden soll.
			% 		[printbib] 		Stellt die benutze Zitate am Endes des Dokuments in dem Literaturverzeichnis dar.
			%		
			% ------------------------------------------
			% Grundeinstellung
			% ------------------------------------------
				% OPTION LUA
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{lua}[true]{}
				\setkeys[rep]{hsrm}{lua=false}

				% OPTION path
				% --> value Path to the folder "asset"
				% --> IMPORTANT: value should not have a "/" at the end
				\define@key[rep]{hsrm}{path}[.]{\def\hsrm@path{#1}}
				\setkeys[rep]{hsrm}{path=.}
			%
			% ------------------------------------------
			% Struktur
			% ------------------------------------------
				% OPTION thesis -> short report	
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{thesis}[true]{}
				\setkeys[rep]{hsrm}{thesis=false}
		
				% OPTION Ignore Chapter numbering
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{section}[true]{}
				\setkeys[rep]{hsrm}{section=false}

				% OPTION thesis -> short report	
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{sperrvermerk}[true]{}
				\setkeys[rep]{hsrm}{sperrvermerk=true}

				% OPTION eigenstaendigkeit -> short report	
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{eigenstaendigkeit}[true]{}
				\setkeys[rep]{hsrm}{eigenstaendigkeit=false}
			%
			% ------------------------------------------
			% Darstellung
			% ------------------------------------------
				% OPTION Ignore Chapter numbering
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{banner}[false]{}
				\setkeys[rep]{hsrm}{banner=true}
				
				% OPTION Ignore Chapter numbering
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{backgroundlogo}[false]{}
				\setkeys[rep]{hsrm}{backgroundlogo=true}

				% OPTION Ignore Chapter numbering
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{coloredheadline}[true]{}
				\setkeys[rep]{hsrm}{coloredheadline=false}
				
				% OPTION Ignore Chapter numbering
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{flama}[true]{}
				\setkeys[rep]{hsrm}{flama=false}
				
				% OPTION Ignore Chapter numbering
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{georgia}[true]{}
				\setkeys[rep]{hsrm}{georgia=false}

				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{svg}[true]{}
				\setkeys[rep]{hsrm}{svg=false}
			%
			% ------------------------------------------
			% Verzeichnisse
			% ------------------------------------------
				% OPTION Ignore Chapter numbering
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{listingsforcontent}[true]{}
				\setkeys[rep]{hsrm}{listingsforcontent=false}

				% OPTION tableofcontent
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{toc}[true]{}
				\setkeys[rep]{hsrm}{toc=true}
		
				% OPTION listoffigures
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{lof}[true]{}
				\setkeys[rep]{hsrm}{lof=false}
		
				% OPTION listoftables
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{lot}[true]{}
				\setkeys[rep]{hsrm}{lot=false}
				
				% OPTION listoflistings
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{lol}[true]{}
				\setkeys[rep]{hsrm}{lol=false}
			%
			% ------------------------------------------	
			% Bibliothek
			% ------------------------------------------
				% OPTION bibfile
				% --> values = file name of your bibtex file
				\define@key[rep]{hsrm}{bibfile}[bib-refs]{\def\hsrm@bibfile{#1}}
				\setkeys[rep]{hsrm}{bibfile=bib-refs}
				
				% OPTION printbibliography
				% --> Werte = true|false
				\define@boolkey[rep]{hsrm}{printbib}[true]{}
				\setkeys[rep]{hsrm}{printbib=false}
		
				% OPTION bibstyle
				% --> values = biblatex style options
				\define@key[rep]{hsrm}{bibstyle}[alphabetic]{\def\hsrm@bibstyle{#1}}
				\setkeys[rep]{hsrm}{bibstyle=numeric-comp}
			%
			% ------------------------------------------
			% Sonstiges
			% ------------------------------------------				
				\define@boolkey[rep]{hsrm}{emoji}[true]{}
				\setkeys[rep]{hsrm}{emoji=false}
			%

			% Verarbeitung der nicht zuweisbaren Optionen
			\DeclareOptionX*{
				\PackageWarning{hsrmreport}{Unknown option ‘\CurrentOption’}%
			}
			
			\ProcessOptionsX[rep]<hsrm>

			% ------------------------------------------
			% Überprüfung ob alle Dateien vorhanden sind
			% ------------------------------------------
			
				% Prüft ob das Hochschul Logo vorhanden ist
				\IfFileExists{\hsrm@path/.src/logo/banner.svg}{}{\PackageError{hsrm}{Es war mir nicht die Datei "banner.svg" im Ordner "asset/logo" zu finden! Bitte stell sicher, dass der Ordner "asset/logo" im aktuellen Projekt zu finden ist. Du kannst aus einem älternen Projekt diese Datei oder auch Ordner kopieren.}{Falls denoch Probleme auftauchen melde dich bei: timjonas.wechler@student.hs-rm.de}}
				
				% Prüft ob das Hochschul Logo vorhanden ist
				\IfFileExists{\hsrm@path/.src/logo/banner.png}{}{\PackageError{hsrm}{Es war mir nicht die Datei "banner.svg" im Ordner "asset/logo" zu finden! Bitte stell sicher, dass der Ordner "asset/logo" im aktuellen Projekt zu finden ist. Du kannst aus einem älternen Projekt diese Datei oder auch Ordner kopieren.}{Falls denoch Probleme auftauchen melde dich bei: timjonas.wechler@student.hs-rm.de}}

				% Prüft ob Hintergrund vorhanden ist 
				\IfFileExists{\hsrm@path/.src/logo/background.pdf}{}{\PackageError{hsrm}{Es war mir nicht die Datei "background.pdf" im Ordner "asset/logo" zu finden! Bitte stell sicher, dass der Ordner "asset/logo" im aktuellen Projekt zu finden ist. Du kannst aus einem älternen Projekt diese Datei oder auch Ordner kopieren.}{Falls denoch Probleme auftauchen melde dich bei: timjonas.wechler@student.hs-rm.de}}
			%
		%
	%
	% **************************************************
	% Color Definitions
	% ************************************************** 
		\RequirePackage[dvipsnames,table]{xcolor}		%
		\RequirePackage{tikz}							%
		\usetikzlibrary{calc}							%
	
		% **********************************************
		% Definition aller Farben
		% **********************************************	
			\definecolor{gray}{cmyk}{0,0,0,.8}
			\definecolor{red}{cmyk}{0,1,1,0}

			% ------------------------------------------
			% Primär Farben
			% ------------------------------------------	
				\definecolor{Prim}{rgb}{0.882352941,0,0.098039216}
				\definecolor{PrimDark}{rgb}{0.588235294,0,0.058823529}
				\definecolor{WarmGreyDark}{rgb}{0.274509804,0.254901961,0.235294118}
				\definecolor{WarmGreyLight}{rgb}{0.666666667,0.647058824,0.62745098}
			%
			% ------------------------------------------
			% Sekundär Farben
			% ------------------------------------------	
				\definecolor{Sec1}{rgb}{0,0.588235294,0.509803922}
				\definecolor{Sec1Dark}{rgb}{0,0.392156863,0.31372549}
				\definecolor{Sec2}{rgb}{0.294117647,0.745098039,0.882352941}
				\definecolor{Sec2Dark}{rgb}{0.196078431,0.490196078,0.568627451}
	
				\definecolor{Sec3}{rgb}{0.607843137,0.764705882,0.156862745}
				\definecolor{Sec3Dark}{rgb}{0.411764706,0.490196078,0.098039216}
				\definecolor{Sec4}{rgb}{0.254901961,0.156862745,0.509803922}
				\definecolor{Sec4Dark}{rgb}{0.176470588,0.098039216,0.333333333}
	
				\definecolor{Sec5}{rgb}{0.509803922,0.078431373,0.31372549}
				\definecolor{Sec5Dark}{rgb}{0.338345865,0.058823529,0.196078431}
				\definecolor{Sec6}{rgb}{1,0.509803922,0}
				\definecolor{Sec6Dark}{rgb}{0.666666667,0.333333333,0}
			%
		%
	%
	% **************************************************
	% Sprachen und Schrift
	% **************************************************
		% **********************************************
		% Mathematik
		% **********************************************
			\RequirePackage{amsmath} 					% https://mirrors.concertpass.com/tex-archive/macros/latex/required/amsmath/amsldoc.pdf
			\RequirePackage{amssymb} 					%
			\RequirePackage{amsfonts}					%

			%  ---  Wird mit Lua eine neue Schriftart gesetzt, so wird auch in Mathemodus diese neue Schriftart verwendet.
			%		Um dies zu verhintern wird bei der Nutzung von LuaLaTeX das folgende Packet geladen, damit der Mathemodus mit 
			%		der bekannten Schdrift aus LaTeX dargestellt wird und nur der restliche Fließtext in der neuen Schriftart dargestellt wird.
			\ifrep@hsrm@lua
				\RequirePackage[italic]{mathastext}
			\fi
		%
		% **********************************************
		% Schriftart für Fließtext
		% **********************************************
			%  ---  LuaLaTeX verarbeitet Schriften Standardmäßig anders als LaTeX. 
			%		Deswegen werden für die jeweilige Kompelierung unterschiedliche Packete benötigt, da es sonst zu Fehlern kommt.
			\ifrep@hsrm@lua
				\RequirePackage{fontspec}				% Wird benötigt um freie Wahl bei der Schriftart zu haben und wird von LuaLaTeX benötigt.
			\else
				\RequirePackage[utf8]{inputenc}			%
														% [para name] uft8: 
				\RequirePackage{lmodern}				%
				\RequirePackage[T1]{fontenc}			%
														% [para name] T1: 
			\fi


			\RequirePackage[ngerman]{babel}				% Eine Sammlung von verschieden Sprachen, und ermöglicht für diese Sprachen die automatische Worttrennung und die ändert die Bezeichnungen in die jeweilige Sprache. 
														% [para name] ngerman: Worttrennung nach der neuen Rechtschreibung und deutsche Bezeichnungen. 
			\RequirePackage{datetime}					%
			\RequirePackage[ngerman]{varioref}			% Sorgt für intelligente Querverweise (http://texdoc.net/texmf-dist/doc/latex/tools/varioref.pdf)
														% [para name] ngerman: neue deutsche Rechtschreibung 
			\RequirePackage[setspace=false]{scrhack}					%
			\RequirePackage{cancel}						% Text durchstreichen 
			\RequirePackage{ulem}						% Text durchstreichen
			\RequirePackage[right]{eurosym} 			% Ermöglicht das nutzen von \EUR{-Betrag-} (http://www.theiling.de/eurosym.html)
														% [para name] right: Positionierung des Eurosymbol rechts des Betrags 

			\RequirePackage{blindtext}					% Platzhalter Text (https://ctan.mc1.root.project-creative.net/macros/latex/contrib/blindtext/blindtext.pdf)
			\RequirePackage{textcomp}					%

			\RequirePackage{setspace}					% Ermöglicht es den Zeilenabstand anzupassen
			\RequirePackage[							% (https://www.namsu.de/Extra/pakete/Siunitx.html)
				locale=DE,								% [para name] locale: 
				%per-mode=symbol
				per-mode = fraction						% [para name] per-mode:
			]{siunitx} 	
			\RequirePackage[							% advanced quotes (https://ctan.net/macros/latex/contrib/csquotes/csquotes.pdf)
				strict=true,							% 	- warning are errors now
				style=german							% 	- german quotes
			]{csquotes}
			\RequirePackage[all]{nowidow}				% Unterdrückt fast komplett nach einem Seitenumbruch einzelne Zeilen. 
			\RequirePackage{etoc}
			% \RequirePackage{parskip}
			% \RequirePackage[titles]{tocloft}
			\etocchecksemptiness
			\etocsettocdepth{2}			
			
			\newcommand*\localchaptertocname{Kapitelverzeichnis}

			\newcommand*\localchaptertocstyle {%
				\etocsettocstyle {%
					\singlespacing
					\if@twocolumn \@restonecoltrue \onecolumn \else \@restonecolfalse \fi
					\small
					\parskip\z@skip
					\parindent \z@
					{\topskip3cm  % <<<<---- customize
					\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\large\bfseries\selectfont
					{\noindent\large\localchaptertocname}
					\par
					\vskip-.5\baselineskip
					\leavevmode\leaders\hrule\@height\p@\hfill\kern\z@\par
					}%
				}{%
					\vskip-.5\baselineskip
					\leavevmode\hrule\@height\p@\hfill\kern\z@\par
					\bigskip      % <<<<---- customize
					\if@restonecol \twocolumn \fi
					
				}%
			}
			\newcommand{\localtoc}{
				\localchaptertocstyle
				\localtableofcontents
			}
			% ------------------------------------------
			% Setzen der gewünschten Schriftarten
			% ------------------------------------------
				%  ---  Wenn mit LuaLaTeX kompeliert wird müssen noch weitere Sachen beachtet werden. Zum einen wurden von mir mehrere Schriften als Fließtextschriftart festgelegt. 
				%		Diese müssen gegebenfalls noch installiert werden. 
				%		<Flama> ist aus dem Coorperatdesign der Hochschule RheinMain. Diese Schrift ist kostenpflichtig und lizenziert.  
				%		Aus diesem Grund habe ich noch eine Alternative hinzugefügt, die Flama ähnlich aussieht (<Source Sans Pro>). 
				%		Im Ordner asset/fonts habe ich dir diese kostenlose Schriften zur Installation bereit gestellt.
				%
				%		Als weitere Schriftart wird in dem Coorperate Design der Hochschule RheinMain die Schriftart <Georgia> aufgeführt.
				%		Diese Schriftart wird bei großem Fließtext benutzt. 
				\ifrep@hsrm@lua
					\ifrep@hsrm@flama
						\newfontfamily{\HeadlineFontExtraLight}{Flama}[
							UprightFont=*-Thin,
							ItalicFont=*-Thin-Italic,
							BoldFont=*-Light,
							BoldItalicFont=*-Light-Italic,
						]%
						\newfontfamily{\HeadlineFontLight}{Flama}[
							UprightFont=*-UltraLight,
							ItalicFont=*-UltraLight-Italic,
							BoldFont=*-Basic,
							BoldItalicFont=*-Basic-Italic,
						]%
						\newfontfamily{\HeadlineFontBold}{Flama}[
							UprightFont=*-Medium,
							ItalicFont=*-MediumItalic,
							BoldFont=*-Bold,
							BoldItalicFont=*-Bold-Italic,
						]%
						\newfontfamily{\HeadlineFontRegular}{Flama}[
							UprightFont=*-Book,
							ItalicFont=*-Book-Italic,
							BoldFont=*-Semibold,
							BoldItalicFont=*-Semibold-Italic,
						]%
					\else
						\newfontfamily{\HeadlineFontExtraLight}{SourceSansPro}[
							UprightFont=*-ExtraLight,
							ItalicFont=*-ExtraLightItalic,
							BoldFont=*-Light,
							BoldItalicFont=*-LightItalic,
						]%
						\newfontfamily{\HeadlineFontLight}{SourceSansPro}[
							UprightFont=*-Light,
							ItalicFont=*-LightItalic,
							BoldFont=*-Regular,
							BoldItalicFont=*-Italic,
						]%
						\newfontfamily{\HeadlineFontBold}{SourceSansPro}[
							UprightFont=*-SemiBold,
							ItalicFont=*-SemiBoldItalic,
							BoldFont=*-Bold,
							BoldItalicFont=*-BoldItalic,
						]%
						\newfontfamily{\HeadlineFontRegular}{SourceSansPro}[
							UprightFont=*-Regular,
							ItalicFont=*-Italic,
							BoldFont=*-SemiBold,
							BoldItalicFont=*-SemiBoldItalic,
						]%
					\fi
					
					\ifrep@hsrm@georgia
						\setmainfont{Georgia}
					\fi
				\fi
			%
			% ------------------------------------------
			% Textformatierung
			% ------------------------------------------
				\setlength{\parindent}{0em}			% Um in einem neuen Abschnitt den Text nicht einrücken zu lassen.
				% \clubpenalty = 10000				% prevent single lines at the beginning of a paragraph (Schusterjungen)
				% \widowpenalty = 10000				% prevent single lines at the end of a paragraph (Hurenkinder)
				% \displaywidowpenalty = 10000		% Einzelne Formelzeile wird unterdrückt 
		
							
				\newcommand{\fontfooterpagenumber}{%
					\color{black}%
					\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\normalsize\selectfont%
				}
				\newcommand{\fontfootertext}{%
					\color{black}%
					\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\footnotesize\selectfont%
				}
				%
				% Inhaltsverzeichnis Tiefe bis zu SubSection
				\setcounter{secnumdepth}{\subsectionnumdepth}
		
			%
			% ------------------------------------------
			% Abschnitte Formatieren
			% ------------------------------------------
				% -- modifications regarding sectioning (structural) commands,
				%    i.e. \part, \chapter, \section, \subsection, \subsubsection, \paragraph
				%
				% 		Koma-Script Dokumentation (https://komascript.de/~mkohm/scrguide.pdf) S. 514
				% 
				% [font]: 		die Formatierung die man im Fließtext sieht
				% [tocindent]: 	wie weit der TOC-Eintrag eingerückt ist 
				% [innerskip]:	Abstand zwischen Prefixzeile und Kapitel, Abschnitt, ...
				% [toc...]: 	alles was den Prefix "toc" hat betrifft das Inhaltsverzeichnis.
				% 				Diese Angaben sind wichtig da sie andere Standardwerte haben. 
				%				Möchte man den Standard von der KOMA-Klasse einfach die Einträge auskommentieren.
				%
				% > formats: \part
					\renewcommand*{\partpagestyle}{empty}
					\RedeclareSectionCommand[
						font=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\fontsize{35}{35}\selectfont,
						prefixfont=\ifrep@hsrm@lua\HeadlineFontBold\else\fontfamily{pbk}\mdseries\fi\fontsize{80}{100}\color{WarmGreyDark}\selectfont,
						tocindent=0pt,
						tocentryformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\Large\selectfont,
						tocpagenumberformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\Large\selectfont,
						innerskip=-0.2\baselineskip,
					]{part}
					\renewcommand*{\partformat}{%
						\tikz[remember picture]\node[inner ysep=-0.4em,inner xsep=0.3em](partnumber)
							{\raisebox{.7em}{\MakeUppercase{\partname}\nobreakspace \fontsize{120}{120}\selectfont{\thepart\autodot}}};%	
					}
				%
				% > formats: \chapter
					\RedeclareSectionCommand[
						font=\ifrep@hsrm@lua\HeadlineFontBold\else\normalfont\fi\ifrep@hsrm@coloredheadline\color{Prim}\else\color{WarmGreyDark}\fi\huge\selectfont,
						tocnumwidth = 2em,
						tocentryformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\bfseries\fi\large\selectfont,
						tocpagenumberformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\bfseries\fi\large\selectfont
					]{chapter}
					\renewcommand*\chapterheadstartvskip{\vspace*{-8.5em}}
					\renewcommand*\chapterheadendvskip{\vspace*{2\baselineskip}}
					\renewcommand*{\chapterformat}{%
						\chapternumber{\thechapter}%
					}
					\renewcommand{\chapterlinesformat}[3]{%
						\chaptertitle{#3}%
						#2\par%
					}
					\newcommand{\chapternumber}[1]{%
						\usekomafont{chapter}%
						\begin{minipage}[t]{0.3\textwidth}%
							\raggedleft{%
								{\vspace*{-0.5cm}\color{black}\rule[0pt]{2pt}{5.5cm}}%
								\quad%
								{\ifrep@hsrm@lua\HeadlineFontRegular\else\bfseries\fi\fontsize{60}{60}\color{gray}\selectfont#1}%
							}%
						\end{minipage}%
					}
					\newcommand{\chaptertitle}[1]{%
						\usekomafont{chapter}%
						\begin{minipage}[t]{0.7\textwidth}%
							\vspace*{5.85em}%
							\raggedright%
							#1%
						\end{minipage}%
					}
				%
				% > formats: \section
					\RedeclareSectionCommand[
						font=\ifrep@hsrm@lua\HeadlineFontBold\else\normalfont\fi\ifrep@hsrm@coloredheadline\color{Prim}\else\color{WarmGreyDark}\fi\LARGE\selectfont,
						tocindent =2em,
						tocentryformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi,
						tocpagenumberformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\selectfont,
						toclinefill=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\TOCLineLeaderFill\selectfont,
					]{section}
				%
				% > formats: \subsection
					\RedeclareSectionCommand[
						font=\ifrep@hsrm@lua\HeadlineFontBold\else\normalfont\fi\ifrep@hsrm@coloredheadline\color{Prim}\else\color{WarmGreyDark}\fi\Large\selectfont,
						tocindent = 4.25em,
						tocentryformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\small\selectfont,
						tocpagenumberformat=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\small\selectfont,
						toclinefill=\ifrep@hsrm@lua\HeadlineFontLight\else\normalfont\fi\TOCLineLeaderFill\selectfont,
					]{subsection}
				%
				% > formats: \subsubsection
					\RedeclareSectionCommand[
						font=\ifrep@hsrm@lua\HeadlineFontBold\else\normalfont\fi\ifrep@hsrm@coloredheadline\color{Prim}\else\color{WarmGreyDark}\fi\large\bfseries\selectfont,
					]{subsubsection}

				%
				% > formats: \paragraph
					\RedeclareSectionCommand[
						font=\ifrep@hsrm@lua\HeadlineFontBold\else\normalfont\fi\ifrep@hsrm@coloredheadline\color{Prim}\else\color{WarmGreyDark}\fi\bfseries\selectfont\maybe@addperiod
					]{paragraph}

					\newcommand{\maybe@addperiod}[1]{%
						#1\;\;\;\textemdash%
					}
					
				%
				


			%
		%
	%
	% **************************************************
	% Grafiken und Bilder
	% **************************************************
		\RequirePackage[								% modify figure and table captions
			font={small}, 								% 	- small font size
			labelfont={footnotesize,sf,bf},				% 	- 
			textfont={footnotesize,sf},					%
			labelsep=colon,								% 	- separator: none, colon, period, space, quad, newline, endash
			singlelinecheck=false,						% 	- no centered single-lined captions
			justification=centering						%
		]{caption}										%
		\RequirePackage{graphicx}						% Das Standardpaket zum Einbinden von Bildern / Grafiken. 
		\RequirePackage{wrapfig}						% Mit oder von Schrift umflossen Bilder.
		\RequirePackage[ 								% für die Unterbilder %---------
			font={scriptsize,sl},						%
			captionskip=3pt								%
		]{subfig}										%
		\RequirePackage{svg}							%
		\ifrep@hsrm@lua									%
			\RequirePackage{emoji}						%
		\fi												%
	%
	% **************************************************
	% Tabellen
	% **************************************************
		\RequirePackage{tabularx}						% Tabellen mit automatischen Zeilenumbruch.
		\RequirePackage{tabulary}						% Ähnlich wie tabularx, ermöglicht aber das ändern der Ausrichtung der Spalten.
		\RequirePackage{booktabs}						% Schöne Tabellen beziehungsweise sie sehen damit professioneller aus. 
		\RequirePackage{array}							%
		\RequirePackage{multirow}						%
		\RequirePackage{multicol}						%
		\RequirePackage{longtable}						% Tabellen über mehrere Seiten (https://www.namsu.de/Extra/pakete/Longtable.html)
		\RequirePackage{csvsimple}						%
	% 
	% **************************************************
	% Listen
	% **************************************************
		\RequirePackage{enumitem}						% for simple list modifications
		\RequirePackage[german,intoc]{nomentbl} 		% vier Spalten bei Formelzeichenverzeichnis (http://vesta.informatik.rwth-aachen.de/ftp/pub/mirror/ctan/macros/latex/contrib/nomentbl/nomentbl.pdf)		
		\RequirePackage{listings}						%
		\renewcommand{\lstlistingname}{Code}			% Listing -> Code
		\renewcommand{\lstlistlistingname}{Codeverzeichnis}% List of Listings -> Codeverzeichnis
		%				
		% **********************************************
		% Textformatierung
		% **********************************************
		%
	% 
	% **************************************************
	% Aussehen und Gestaltung von Dokumenten
	% **************************************************
		\RequirePackage{geometry}						%
		\RequirePackage{calc}							%
		\RequirePackage{scrlayer-scrpage}  				%
		% \RequirePackage{setspace}						% Um den Zeilenabstand zu ändern, e.g. \onehalfspacing
		\RequirePackage[hyphens]{url}					%
	
		\RequirePackage[								%
			pdftitle={Titel},    						%   - title (PDF meta)
			pdfsubject={Dokumentenart},					%   - subject (PDF meta)
			pdfauthor={autor},    						%   - author (PDF meta)
			plainpages=false,           				%   -
			colorlinks=true,           					%   - farbige Links
			linkcolor={black},							%
			anchorcolor={black},						%
			citecolor={Sec1},							%
			filecolor={Sec3},							%
			menucolor={black},							%
			runcolor={Sec5}, 							%	- same as file color
			urlcolor={Sec6},							%
			%allcolors=any_color						%	- use this if you want to set all links to the same color
			pdfborder={0 0 0},         	 				%   - 
			breaklinks=true,            				%   - allow line break inside links
			linktoc=all,								% 	- ermöglicht klickbare Links im Inhaltsverzeichnis
			bookmarksnumbered=true,     				%	- 
			bookmarksopen=true          				%	- 
		]{hyperref} 									% Erstellt Verweise innerhalb und nach außerhalb eines PDF Dokumentes.
		\RequirePackage{bookmark}						%
		\RequirePackage{makeidx}						% Anlegen eines Stichwortverzeichnis.
		\RequirePackage{parallel}						% Ermöglicht Text in mehreren Spalten nebeneinander zu stellen (https://texfaq.org/FAQ-parallel)
		% \RequirePackage[								%
		% 	nonumberlist, 								% keine Seitenzahlen anzeigen
		% 	acronym,      								% ein Abkürzungsverzeichnis erstellen
		% 	toc,          								% Einträge im Inhaltsverzeichnis
		% 	section      								% im Inhaltsverzeichnis auf section-Ebene erscheinen
		% ]{glossaries}									%
		% \RequirePackage[								%
		% 	record,										%
		% 	stylemods,									%
		% 	style=listgroup								%
		% ]{glossaries-extra}								%
		% \RequirePackage{tablefootnote}				% Für Fußnoten (http://vesta.informatik.rwth-aachen.de/ftp/pub/mirror/ctan/macros/latex/contrib/tablefootnote/tablefootnote.pdf)
		
		% **********************************************
		% Weitere Einstellungen für den Seitenaufbau
		% **********************************************
			\clearpairofpagestyles
			\geometry{
				%showframe, % <========================================================
				tmargin=25mm,        % top    
				rmargin=25mm,       % right (outer)
				heightrounded,
				includeheadfoot=false,
				inner=25mm,
				outer=25mm,
				headheight=7mm,     % 
				headsep=9mm,        % 
				foot=40pt,          %
				footskip=40mm,
				bottom=25mm,
				marginparsep=2mm,   % 
				marginparwidth=18mm % 
			}
			\ifrep@hsrm@thesis
				\geometry{
					twoside
					%,showframe
					}
			\fi
		%
		% **********************************************
		% Header Footer Definition
		% **********************************************
			\automark[section]{chapter}         		% automatically marks sections as rightmark
														% and chapters as leftmark
			\setlength{\footheight}{80pt}
			\pagestyle{scrheadings}
														% the outer border
			\setkomafont{pagefoot}{\fontfootertext}           % font for footer
			\setkomafont{pagenumber}{\fontfooterpagenumber}   % font for page numbers
	
			%% Redefinition of the chaptermark (used for footer mark on even (left) pages)
			\renewcommand{\chaptermark}[1]{%
				\markboth{%
				\ifnum\value{chapter}>0
					\fontfootertext
					% use \@chapapp instead of \chaptername to avoid
					% 'Chapter A Appendix ...', thanks to @farbverlust (issue #47)
					{\color{WarmGreyDark}\textbf{\@chapapp\ \thechapter\;}}%
					%\hspace{.25cm}%
					\begin{minipage}[t]{.84\linewidth}%
						#1%
					\end{minipage}%
				\fi
				}{}%
			}
	
			%% Redefinition of the sectionmark (used for footer mark on odd (right) pages)
			\renewcommand{\sectionmark}[1]{%
				\markright{%
				\ifnum\c@secnumdepth>\@ne
						\fontfootertext
						\raggedleft%
						{\color{WarmGreyDark}\textbf{\thesection}}%
					\hspace{.25cm}%
					\begin{minipage}[t]{\minof{\widthof{#1}}{.7\textwidth}}%
						#1%
					\end{minipage}%			
				\fi
				}%  
			}
	
			%% Vertical line in the footer (between page number and mark)
			\newcommand{\footerline}{%
				\color{black}\rule[-35pt]{1.25pt}{45pt}%
			}
			%% Page number for odd (right) pages
			\newcommand{\footerrightpagenumber}{%
				\hfill {\footerline\hspace*{5pt} \pagemark}
			}
	
			%% Page number for even (left) pages
			\newcommand{\footerleftpagenumber}{%
				\hfill {\footerline\hspace*{5pt} \pagemark}
				%\llap{\pagemark\hspace*{5pt}\footerline}
			}
	
			\lehead{}
			\cehead{}
			\rehead{}
			\ifrep@hsrm@thesis\else 
				\lohead{\leftmark}
			\fi
			\cohead{}
			\rohead{}
			\lefoot[%   > plain
				\footerleftpagenumber%
			]{%         > srcheadings
				\hspace{-2cm}
				\footerleftpagenumber%
				\hspace{0.75cm}%
				\headmark%
			}
			\cefoot{}
			\refoot{}
			\lofoot{}
			\cofoot{}
			\rofoot[%   > plain
				\footerrightpagenumber%
			]{%         > srcheadings
				\headmark%
				\hspace*{0.75cm}%
				\footerrightpagenumber%
			}
			
		%
	% 
	% **************************************************
	% Bibliography
	% **************************************************
		\RequirePackage[					% use biblatex for bibliography
			backend=biber,      % biber or bibtex
			%,style=authoryear    % Alphabeticalsch
			style=\hsrm@bibstyle,  % numerical-compressed
			sorting=none,        % no sorting
			sortcites=true,      % some other example options ...
			block=none,
			indexing=false,
			citereset=none,
			isbn=true,
			url=true,
			doi=true,				% prints doi
			natbib=true,			% if you need natbib functions
		]{biblatex}
		\DefineBibliographyStrings{ngerman}{%
			bibliography  = {Quellenverzeichnis},
			andothers = {{et\,al\adddot}}, % 'et al.' instead of 'u.a.'
			backrefpage = {{zitiert auf Seite}},%
			backrefpages = {{zitiert auf den Seiten}},%
		}
	%
	% Gloassraies
		\RequirePackage[record,% use bib2gls
			section,% use \section* for glossary headings
			% postdot,% insert dot after descriptions in glossaries
			nomain,% don't create 'main' glossary
			nostyles,% don't load default styles
			% load and patch required style packages:
			toc=false,
			stylemods={list,mcols,tree,bookindex,longbooktabs}
		]{glossaries-extra}
		
		\newglossary*{erklaer}{Begriffserklärung}
		\newglossary*{abkuerz}{Abkürzungsverzeichnis}
		\newglossary*{math}{Mathematische Symbole}
		\newglossary*{units}{Physikalsiche Größen}

		% define custom glossary style
		\newglossarystyle{units}% style name
		{% base it on long3col-booktabs
			\setglossarystyle{long3col-booktabs}%
			\renewcommand*{\glossaryheader}{%
				\toprule 
				\bfseries Name &
				\bfseries Bezeichnung &
				\bfseries Einheit
				\tabularnewline\midrule\endhead
				\bottomrule\endfoot}%
			% main entries:
			\renewcommand{\glossentry}[2]{%
				\glsentryitem{##1}\glstarget{##1}{\glossentryname{##1}} &
				\glossentrydesc{##1}\glspostdescription &
				\glossentrysymbol{##1}\tabularnewline
			}%
		}
	%
	% ToDo-List 
		\RequirePackage{soul} % for the command \hl
		\RequirePackage[colorinlistoftodos]{todonotes}
			\todostyle{warning}{linecolor=Prim, backgroundcolor=Prim!20,
			bordercolor=Prim,shadow}
			\todostyle{info}{linecolor=Sec3, backgroundcolor=Sec3!20,
			bordercolor=Sec3}
	% **************************************************
	% New Commands
	% **************************************************
		% ref commands, e.g. for images, tables and text labels
		% ----------------------------------------------
		% RESULT = (siehe Tab. 12.4)
		\newcommand{\tabref}[1]{(siehe Tab.~\ref{#1})}
		%
		% RESULT = (siehe Tab. 12.4 Seite 12)
		\newcommand{\tableref}[1]{(siehe Tab.~\ref{#1}, Seite~\pageref{#1})}
		%
		% ----------------------------------------------
		% RESULT = (siehe 3.4)
		\newcommand{\tref}[1]{(siehe \ref{#1})}
		%
		% RESULT = Abschnitt 3.4
		\newcommand{\treft}[1]{Abschnitt~\ref{#1}}
		%
		% RESULT = (siehe 3.4, Seite 12)
		\newcommand{\textref}[1]{(siehe Abschnitt~\ref{#1}, Seite~\pageref{#1})}
		%
		% RESULT = Abschnitt 3.4 (siehe Seite 12)
		\newcommand{\textreft}[1]{Abschnitt~\ref{#1} (siehe Seite~\pageref{#1})}
		%
		% ----------------------------------------------
		% RESULT = (siehe Abb. 10.4)
		\newcommand{\fref}[1]{(siehe Abb.~\ref{#1})}
		%
		% RESULT = (siehe Abb. 10.4 b)
		\newcommand{\frefadd}[2]{(siehe Abb.~\ref{#1}~#2)}
		%
		% RESULT = (siehe Abb. 10.4, Seite 12)
		\newcommand{\figref}[1]{(siehe Abb.~\ref{#1}, Seite~\pageref{#1})}
		%
		% RESULT = (siehe Abb. 10.4 b, Seite 12)
		\newcommand{\figrefadd}[2]{(siehe Abb.~\ref{#1}~#2, Seite~\pageref{#1})}
		%
		% RESULT = Abbildung 10.4
		\newcommand{\figreft}[1]{Abbildung~\ref{#1}}
		%
		% RESULT = Abbildung 10.4 b
		\newcommand{\figrefaddt}[2]{Abbildung~\ref{#1}~#2}
		%
		% ----------------------------------------------
		% RESULT = (siehe Seite 12)
		\newcommand{\seepage}[1]{(siehe Seite~\pageref{#1})}
		\newcommand{\spage}[1]{(Seite~\pageref{#1})}
	
		% \renewcommand{\tt}[1]{\texttt{\color{red}{#1}}}
	
		% \renewcommand{\bf}[1]{\textbf{#1}}
		
	
	%
	% **************************************************
	% Titelseite
	% **************************************************			
		% **********************************************
		% Variabeln
		% **********************************************
			\def\Titel@internal{}
			\newcommand{\Titel}[1]{\gdef\Titel@internal{#1}}
			\newcommand{\insertTitel}{\ifx\Titel@internal\empty\else\Titel@internal\fi}
			
			\def\Fachbereich@internal{}
			\newcommand{\Fachbereich}[1]{\gdef\facbereich@internal{#1}}
			\newcommand{\insertFachbereich}{\ifx\Fachbereich@internal\empty Ingenieurwissenschaften\else\Fachbereich@internal\fi}

			\def\Studiengang@internal{}
			\newcommand{\Studiengang}[1]{\gdef\Studiengang@internal{#1}}
			\newcommand{\insertStudiengang}{\ifx\Studiengang@internal\empty Angewandte Physik\else\Studiengang@internal\fi}

			\def\Studienrichtung@internal{}
			\newcommand{\Studienrichtung}[1]{\gdef\Studienrichtung@internal{#1}}
			\newcommand{\insertStudienrichtung}{\ifx\Studienrichtung@internal\empty Physikalische Technik\else\Studienrichtung@internal\fi}

			% \def\Dokumentenart@internal{}
			% \newcommand{\Dokumentenart}[1]{\gdef\Dokumentenart@internal{#1}}
			% \newcommand{\insertDokumentenart}{\ifx\Dokumentenart@internal\empty\else\Dokumentenart@internal\fi}

			\def\Kurs@internal{}
			\newcommand{\Kurs}[1]{\gdef\Kurs@internal{#1}}
			\newcommand{\insertKurs}{\ifx\Kurs@internal\empty\else\Kurs@internal\fi}

			\def\VersuchsdurchfuehrungDatum@internal{}
			\newcommand{\VersuchsdurchfuehrungDatum}[1]{\gdef\VersuchsdurchfuehrungDatum@internal{#1}}
			\newcommand{\insertVersuchsdurchfuehrungDatum}{\ifx\VersuchsdurchfuehrungDatum@internal\empty\else Versuchsdurchführung: \VersuchsdurchfuehrungDatum@internal\fi}
			
			\def\AbgabeOrt@internal{}
			\newcommand{\AbgabeOrt}[1]{\gdef\AbgabeOrt@internal{#1}}
			\newcommand{\insertAbgabeOrt}{\ifx\AbgabeOrt@internal\empty Rüsselsheim am Main\else\AbgabeOrt@internal\fi}
			
			\def\Datum@internal{}
			\newcommand{\Datum}[1]{\gdef\Datum@internal{#1}}
			\newcommand{\insertDatum}{\ifx\Datum@internal\empty\today\else\Datum@internal\fi}

			\def\Unternehmen@internal{}
			\newcommand{\Unternehmen}[1]{\gdef\Unternehmen@internal{#1}}
			\newcommand{\insertUnternehmen}{\ifx\Unternehmen@internal\empty\else\Unternehmen@internal\fi}


		%
		% **********************************************
		% LaTeX3 Code
		% **********************************************
			\ExplSyntaxOn
				% --------------------------------------
				% Variablen - Studierende und Autor
				% --------------------------------------
					% Speichert alle Namen der Studierenden und deren Matrikelnummer
					% Außerdem werden auch die Angaben der Verfasserin bzw. des Verfassers gespeichert
					% Mit \l_student_name_seq und \l_student_mat_seq werden Aufzählungen erstellt.
					\seq_new:N \l_student_name_seq
					\seq_new:N \l_student_mat_seq
					
					% Diese Variable wird für die Eingabeüberprüfung der Matrikelnummer benutzt
					\int_zero_new:N \l_test_mat_int
					
					% Mit \l_student_liste_tl wird der aus zugebende Inhalt abgespeichert, 
					% der auf der Titelseite dagestellt werden soll.
					\tl_new:N \l_student_liste_tl
				%
				% --------------------------------------
				% Variablen - Autor
				% --------------------------------------
					% Die Variable \l_autor_liste_tl wird für den gleichen Zweck wie \l_student_liste_tl benutzt.
					\tl_new:N \l_autor_liste_tl
					\tl_new:N \l_autor_name_tl
					\tl_new:N \l_autor_matnr_tl
					\tl_new:N \l_autor_strasse_tl
					\tl_new:N \l_autor_stadt_tl
					\tl_new:N \l_autor_plz_tl
				%
				% --------------------------------------
				% Variablen - Beteiligte
				% --------------------------------------
					% Beinhaltet alle Angaben der Beteiligde der verfassten Thesis
					\tl_new:N \l_beteiligte_tl
				%
				% --------------------------------------
				% Variablen - Beteiligte
				% --------------------------------------
					% Beinhaltet alle Angaben der Beteiligde der verfassten Thesis
					\tl_new:N \l_dokumentenart_tl
				%
				% --------------------------------------
				% Funktionen - Studierende
				% --------------------------------------
					% Mit \Studierende werden die Eingaben in in die jeweilige Variablen abgespeichert.
					%	1. [Name] 	
					%	2. [Matrikelnummer]
						\newcommand{\Studierende}[2]{
							
							\seq_put_right:Nn \l_student_name_seq {#1}
							\seq_put_right:Nn \l_student_mat_seq {#2}

							\tl_put_right:Nn \l_student_liste_tl {& {\Large#1}\ }
							\tl_if_eq:nnTF {} {#2} {\int_set:Nn \l_test_mat_int {0}} {\int_set:Nn \l_test_mat_int {#2}}				
							\int_compare:nNnTF {\l_test_mat_int} > {0} {\tl_put_right:Nn \l_student_liste_tl {(#2)\\}} {\tl_put_right:Nn \l_student_liste_tl {\\}}
						}
					%
					% Mit \studierndenPerson kann der Name einer gewünschten Person ausgegeben werden.
					%   1. [Nummmer]  -> Die Aufzählung beginnt bei 1
						\newcommand{\studierendePerson}[1]{
							\seq_item:Nn \l_student_name_seq {#1}
						}
					%
					% Mit \studierendePersonMatrikelnummer kann die Matrikelnummer einer gewünschten Person ausgegeben werden. 
					%   1. [Nummmer]  -> Die Aufzählung beginnt bei 1
						\newcommand{\studierendePersonMatrikelnummer}[1]{
							\seq_item:Nn \l_student_mat_seq {#1}
						}
					%
					% Ausgabe aller Studierenden.
						\newcommand{\alleStudierendeanzeigen}{
							\l_student_liste_tl					
						}
					%
				%
				% --------------------------------------
				% Funktionen - Autor
				% ------------------------------------------
					% \Autor speichert die Eingabe mit der passenden Formatierung.
					% Diese Angabe kann später mit \Autoranzeigen ausgegeben werden. 
					% -> HINWEIS: Es kann nur einen Autor geben. (Diese Angabe wird nur für eine Thesis benutzt)
						\newcommand{\Autor}[2]{
							\tl_put_right:Nn \l_autor_liste_tl {{\Large#1}\ (#2)}
							\tl_put_right:Nn \l_autor_name_tl {#1\\}
							\tl_put_right:Nn \l_autor_matnr_tl {#2\\}
						}
					%
					% Ausgabe der Person die dieses Dokument erstellt hat.
						\newcommand{\Autoranzeigen}{
							\l_autor_liste_tl
						}
					%
					% Ausgabe des Namens der Person die dieses Dokument erstellt hat.
						\newcommand{\Autorname}{
							\l_autor_name_tl
						}
					%
					% Adresse des Person 
						\newcommand{\Strasse}[1]{
							\tl_put_right:Nn \l_autor_strasse_tl {#1}
						}
						\newcommand{\PLZ}[1]{
							\tl_put_right:Nn \l_autor_plz_tl {#1\ }
						}
						\newcommand{\Wohnort}[1]{
							\tl_put_right:Nn \l_autor_stadt_tl {#1\ }
						}
					%
					% Adresse ausgeben 
						\newcommand{\Strasseanzeigen}{
							\l_autor_strasse_tl
						}
						\newcommand{\PLZanzeigen}{
							\l_autor_plz_tl
						}
						\newcommand{\Wohnortanzeigen}{
							\l_autor_stadt_tl
						}
					%

				
				% ------------------------------------------
				% Funktionen - Beteiligte
				% ------------------------------------------
					\newcommand{\Beteiligte}[2]{
						\tl_put_right:Nn \l_beteiligte_tl {\textit{#1}&{#2}\\}
					}
					\newcommand{\alleBeteiligteanzeigen}{
						% outputs \l_beteiligte_tl
						\tl_use:N \l_beteiligte_tl
					}
				%
				% ------------------------------------------
				% Funktionen - Dokumentenart
				% ------------------------------------------
					\newcommand{\Dokumentenart}[1]{
						\tl_put_right:Nn \l_dokumentenart_tl {#1~}
					}
					\newcommand{\insertDokumentenart}{
						% outputs \l_beteiligte_tl
						\tl_use:N \l_dokumentenart_tl
					}
				%
			\ExplSyntaxOff
		
					




		\newcommand{\Deckblatt}[1]{
			\pagestyle{empty}	

				% Erstellt in der Übersicht der PDF-Datei den Eintrag "Titelseite"
				\pdfbookmark[0]{Titleseite}{Titleseite}
				{
					\ifrep@hsrm@lua\HeadlineFontRegular\else\sffamily\fi
					\ifrep@hsrm@banner
						\ifrep@hsrm@svg
							\begin{tikzpicture}[remember picture,overlay,every node/.style={inner sep=0,outer sep=0}]
								\node (back names) [shape=rectangle, minimum height=50mm, minimum width=\paperwidth, anchor=north west] at (current page.north west) {\includesvg[width=\paperwidth]{\hsrm@path/.src/logo/banner}};
							\end{tikzpicture}
						\else
							\begin{tikzpicture}[remember picture,overlay,every node/.style={inner sep=0,outer sep=0}]
								\node (back names) [shape=rectangle, minimum height=50mm, minimum width=\paperwidth, anchor=north west] at (current page.north west) {\includegraphics[width=\paperwidth]{\hsrm@path/.src/logo/banner.png}};
							\end{tikzpicture}
						\fi
					\fi
					\ifrep@hsrm@backgroundlogo
						\begin{tikzpicture}[remember picture,overlay,every node/.style={inner sep=0,outer sep=0}]
							\node (back names) [shape=rectangle, minimum height=50mm, minimum width=0.5\paperwidth, anchor=south east] at (current page.south east) {\includegraphics[width=0.5\paperwidth]{\hsrm@path/.src/logo/background.pdf}};
						\end{tikzpicture}
					\fi
					
					\centering
					\ifrep@hsrm@banner
						\vspace{3cm}
					\fi
					\centering
					
					% Das Logo mit Namen wird eingefügt
					% \includegraphics[width=6cm]{asset/logo/logo_hsrm} \\[-1mm]
					\text{Fachbereich \insertFachbereich} \\
					% Die Folgende angaben sind aus den Variablen in der main.tex zu entnehmen
					\text{Studiengang \insertStudiengang} \\
					\text{Studienrichtung \insertStudienrichtung} \\ [35mm]

					\text{\large \insertDokumentenart} \\[5mm]
					\text{\LARGE \textbf{#1}}\par\smallskip
					\text{\large \textbf{\insertKurs}}\par\medskip
					\ifrep@hsrm@thesis\else
						{\insertVersuchsdurchfuehrungDatum}
					\fi
				
					\vfill
					\ifrep@hsrm@thesis
						% Angaben zu den Autoren des Dokuments 
						\begin{tabular}[\textwidth]{rl}
							vorgelegt von 	& \Autoranzeigen \\
											& \Strasseanzeigen\\
											& \PLZanzeigen \Wohnortanzeigen\\
											& \\
							\alleBeteiligteanzeigen
						\end{tabular} \\[10mm]
					\else
						% Angaben zu den Autoren des Dokuments 
						\begin{tabular}[\textwidth]{rl}
							\textit{Studierende} \alleStudierendeanzeigen
						\end{tabular} \\[10mm]
					\fi
								
					\begin{center}
						\insertAbgabeOrt, \insertDatum
					\end{center}
									
				}	
			\newpage		
			
			% %Römischen Seitenzahl
			\pagenumbering{Roman}
		}
		
	
	