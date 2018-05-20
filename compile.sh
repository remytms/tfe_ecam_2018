#!/bin/sh

# Title Pages
pandoc tfe-main.yml tfe-paper-a4.yml \
    --template=templates/titlepage.template.tex \
    --latex-engine=xelatex \
-o titlepages/tfe-a4-titlepage.pdf
pandoc tfe-main.yml tfe-paper-a5-binding.yml \
    --template=templates/titlepage.template.tex \
    --latex-engine=xelatex \
-o titlepages/tfe-a5-binding-titlepage.pdf
pandoc tfe-main.yml tfe-paper-a5.yml \
    --template=templates/titlepage.template.tex \
    --latex-engine=xelatex \
-o titlepages/tfe-a5-titlepage.pdf


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
dia diagrams/introspection.dia -t png -s 4000x \
   -e images/introspection.png
dia diagrams/intranet_package.dia -t png -s 4000x \
   -e images/intranet_package.png


# Abstract
pandoc abstract/abstract.md \
    --template=templates/tfe.empty.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o abstract/abstract.tex


# Appendices
pandoc $(cat appendices/toc.txt) \
    --template=templates/tfe.empty.template.tex \
    --top-level-division=chapter \
    --listings \
    --latex-engine=xelatex \
    -o appendices/appendices.tex


# A4 Screen reading version
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


# Compressed version of A4 screen reading version
ps2pdf -dPDFSETTINGS=/ebook "$file.pdf" "$file.compressed.pdf"


# Paper A4 two side
file='tfe-TAYMANS-14291-paper-a4-twoside'
pandoc $(cat content/toc.txt) \
    tfe-main.yml tfe-paper-a4.yml tfe-paper-a4-twoside.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o "$file.tex"

xelatex -halt-on-error "$file.tex"
bibtex "$file"
xelatex -halt-on-error "$file.tex"
xelatex -halt-on-error "$file.tex"

rm "$file.aux" "$file.bbl" "$file.blg" "$file.toc"


# Paper A4 one side
file='tfe-TAYMANS-14291-paper-a4-oneside'
pandoc $(cat content/toc.txt) \
    tfe-main.yml tfe-paper-a4.yml tfe-paper-a4-oneside.yml \
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
