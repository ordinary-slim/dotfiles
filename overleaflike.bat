@echo off

pdflatex -interaction=batchmode %1

if ERRORLEVEL 1 (
	echo ! Compilation failed
) else (
	bibtex %1
	if ERRORLEVEL 1 (
		echo ! Compilation failed
	) else (
		pdflatex -interaction=batchmode %1
		pdflatex -interaction=batchmode %1
		echo Compilation succeeded !
	)
)
