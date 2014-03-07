default: pdf

pdf: 
	pdflatex apostila.tex
	pdflatex apostila.tex

clean:
	rm *.toc
	rm *.pdf
	rm *.log
	rm *.aux
	rm *~
