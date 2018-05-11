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
dot -Tpng -Gdpi=600 diagrams/document-tree.gv \
    -o images/document-tree.png
dot -Tpng -Gpdi=600 diagrams/shift-template.gv \
    -o images/shift-template.png
dot -Tpng -Gpdi=600 diagrams/shift-timeline.gv \
    -o images/shift-timeline.png
dot -Tpng -Gpdi=600 diagrams/shift-planning.gv \
    -o images/shift-planning.png
dot -Tpng -Gpdi=600 diagrams/shift-template-hierarchy.gv \
    -o images/shift-template-hierarchy.png
dot -Tpng -Gpdi=600 diagrams/shift-controller.gv \
    -o images/shift-controller.png
dot -Tpng -Gpdi=600 diagrams/shift-activity.gv \
    -o images/shift-activity.png
dia diagrams/mvc_sequence.dia -t png -s 4000x -e /dev/stdout \
    | convert - -rotate 270 images/mvc_sequence.png

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

# Paper A5 reading version
file='tfe-TAYMANS-14291-paper-a5'
pandoc $(cat content/toc.txt) \
    tfe-main.yml tfe-paper-a5.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o "$file.tex"

xelatex -halt-on-error "$file.tex"
bibtex "$file"
xelatex -halt-on-error "$file.tex"
xelatex -halt-on-error "$file.tex"

rm "$file.aux" "$file.bbl" "$file.blg" "$file.toc"
