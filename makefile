default: pdf

pdf: 
	pdflatex apostila.tex
	pdflatex apostila.tex

clean:
	rm *.toc
	rm *.lof
	rm *.pdf
	rm *.log
	rm *~
