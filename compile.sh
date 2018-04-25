#!/bin/sh

# Title Page
if [ -f "titlepages/tfe-a4-titlepage.pdf" ]
then
    echo "Title Page already generated"
else
    xelatex titlepages/tfe-a4-titlepage.tex
    mv tfe-a4-titlepage.pdf titlepages
fi

# Diagrams
dot -Tpdf diagrams/document-tree.gv -o images/document-tree.pdf

# Abstract
pandoc abstract/abstract.md \
    --template=templates/tfe.empty.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o abstract/abstract.tex

# Screen reading version
file='tfe-TAYMANS-14291-screen'
pandoc $(cat content/toc.txt) \
    tfe-main.yml tfe-screen.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o "$file.tex"

xelatex -halt-on-error "$file.tex"
bibtex "$file"
xelatex -halt-on-error "$file.tex"
xelatex -halt-on-error "$file.tex"

rm "$file.aux" "$file.bbl" "$file.blg" "$file.toc"

# Paper reading version
file='tfe-TAYMANS-14291-paper'
pandoc $(cat content/toc.txt) \
    tfe-main.yml tfe-paper.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o "$file.tex"

xelatex -halt-on-error "$file.tex"
bibtex "$file"
xelatex -halt-on-error "$file.tex"
xelatex -halt-on-error "$file.tex"

rm "$file.aux" "$file.bbl" "$file.blg" "$file.toc"
