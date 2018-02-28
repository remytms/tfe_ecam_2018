#!/bin/sh
pandoc content/* \
    --template=tfe.template.tex \
    --listings \
    -o tfe-TAYMANS-14291.pdf

pandoc content/* \
    --template=tfe.template.tex \
    --listings \
    -o tfe-TAYMANS-14291.tex
