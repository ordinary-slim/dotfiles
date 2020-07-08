@echo off
pdflatex -interaction=batchmode %1
if ERRORLEVEL 1 (
  echo ! Compilation failed
) else (
  echo Compilation succeeded !
)
