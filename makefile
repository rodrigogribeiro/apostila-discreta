default: pdf

pdf: 
	pdflatex apostila.tex
	bibtex apostila.aux
	pdflatex apostila.tex
	pdflatex apostila.tex

clean:
	rm *.toc
	rm *.pdf
	rm *.log
	rm *.aux
	rm *.out
	rm *.blg
	rm *.bbl
	rm *~
