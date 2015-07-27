
MAIN = main
AUXDIR = aux

LATEX = pdflatex

FIGEXT = .pdf
MAINEXT= .pdf
BUILDCOMMAND =$(LATEX) --output-dir=$(AUXDIR) $(MAIN)
BUILDCOMMAND+= && mv $(AUXDIR)/$(OUTPUT) $(OUTPUT)

# list of all source files
TEXSOURCES = $(wildcard *.tex) $(wildcard *.bib)
FIGSOURCES = $(wildcard figs/*$(FIGEXT))
SOURCES    = $(TEXSOURCES) $(FIGSOURCES)

# define output (could be making .ps instead)
OUTPUT = $(MAIN)$(MAINEXT)

# prescription how to make output (your favorite commands to process latex)
# do latex twice to make sure that all cross-references are updated
$(OUTPUT): $(SOURCES) Makefile
	rm -f $(MAIN).aux && $(BUILDCOMMAND)
	mv $(MAIN)$(MAINEXT) books$(MAINEXT)

# just so we can say "make all" without knowing the output name
all: $(OUTPUT)

# remove temporary files (good idea to say "make clean" before putting things back into repository)
.PHONY : clean open

clean:
	rm -f $(AUXDIR)/* $(MAIN)$(MAINEXT)

open:
	open $(MAIN)$(MAINEXT)
