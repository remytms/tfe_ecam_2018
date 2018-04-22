#!/bin/sh

# Title Page
if [ -f "titlepages/tfe-a4-titlepage.pdf" ]
then
    echo "Title Page already generated"
else
    xelatex titlepages/tfe-a4-titlepage.tex
    mv tfe-a4-titlepage.pdf titlepages
fi

# Abstract
pandoc abstract/abstract.md \
    --template=templates/tfe.empty.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o abstract/abstract.tex

# Screen reading version
pandoc content/*.md \
    tfe-main.yml tfe-screen.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o tfe-TAYMANS-14291-screen.tex

pandoc content/*.md \
    tfe-main.yml tfe-screen.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o tfe-TAYMANS-14291-screen.pdf

# Paper reading version
pandoc content/*.md \
    tfe-main.yml tfe-paper.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o tfe-TAYMANS-14291-paper.tex

pandoc content/*.md \
    tfe-main.yml tfe-paper.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o tfe-TAYMANS-14291-paper.pdf

