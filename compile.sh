#!/bin/sh
pandoc content/*.md \
    --template=tfe.template.tex \
    --listings \
    -o tfe-TAYMANS-14291.pdf

pandoc content/*.md \
    --template=tfe.template.tex \
    --listings \
    -o tfe-TAYMANS-14291.tex
