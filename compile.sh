#!/bin/bash

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


# Paper A5 big binding
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


# Paper A5 small binding
file='tfe-TAYMANS-14291-paper-a5-binding'
pandoc $(cat content/toc.txt) \
    tfe-main.yml tfe-paper-a5-binding.yml \
    --template=templates/tfe.template.tex \
    --listings \
    --latex-engine=xelatex \
    -o "$file.tex"

xelatex -halt-on-error "$file.tex"
bibtex "$file"
xelatex -halt-on-error "$file.tex"
xelatex -halt-on-error "$file.tex"

rm "$file.aux" "$file.bbl" "$file.blg" "$file.toc"


# Prepare A5 notes Pages
notea5_file='endpages/notes-a5'
pandoc tfe-paper-a5-binding.yml \
    --template=templates/notes.template.tex \
    --latex-engine=xelatex \
    -o "$notea5_file.pdf"

# Prepare A5 for printing and binding in signature
file='tfe-TAYMANS-14291-paper-a5-binding'
working_file="$file.working"
nbsheet=4 # sheets per signature
cp "$file.pdf" "$working_file.pdf"
npage=$(pdfinfo "$working_file.pdf" | \
    grep Pages | \
    sed 's/[^0-9]*//')
echo "Currently $npage page(s)"
if [ $(($npage % $nbsheet)) -eq 0 ]
then
    nbpagetoadd=0
    echo "Nothing to add"
else
    nbpagetoadd=$(($nbsheet - ($npage % $nbsheet)))
    echo "Need to add $nbpagetoadd page(s)"
fi
for (( idx=1; idx<=nbpagetoadd; idx++ ))
do
    echo "Number of pages is $npage"
    echo "Adding the page number $idx"
    pdftk A="$working_file.pdf" B="$notea5_file.pdf" \
        cat A1-$(($npage - 1)) B1 A$npage \
        output combined.pdf
    mv combined.pdf "$working_file.pdf"
    npage=$(($npage + 1))
done
echo "Now number of pages is $npage"

page_last_signature=$(( $npage % ($nbsheet * 4) ))
if [ $page_last_signature -eq 0 ]
then
    # Here don't need to cut the file we can just make signature of 16
    # pages
    echo "There is a integer number of signatures"
    pdf2ps -dNOCACHE "$working_file.pdf" - | \
        psbook -s$(( $nbsheet * 4 )) | \
        psnup -s1 -2 | \
        ps2pdf -dPDFSETTINGS=/prepress - "$file.booklet.pdf"
else
    # Here the pdf must be cutted to make signature of 16 pages and the
    # last one with more pages
    echo "Need two part for the book"
    nb_signature_begin=$(($npage / 16 - 1))
    echo "There is $nb_signature_begin signature for the begining of \
the book"
    cut_page=$(($nb_signature_begin * 16))
    echo "The cut page is page $cut_page"
    echo "The first part contains $nb_signature_begin signature(s) of \
4 sheets"
    echo "The second part contains one signature of \
$(( ($npage - $cut_page) / 4 )) sheets"
    pdftk A="$working_file.pdf" cat A1-$cut_page output - | \
        pdf2ps -dNOCACHE - - | \
        psbook -s$(( $nbsheet * 4 )) | \
        psnup -s1 -2 | \
        ps2pdf -dPDFSETTINGS=/prepress - "$file.booklet.part1.pdf"
    pdftk A="$working_file.pdf" cat A$(($cut_page + 1))-end output - | \
        pdf2ps -dNOCACHE - - | \
        psbook | \
        psnup -s1 -2 | \
        ps2pdf -dPDFSETTINGS=/prepress - "$file.booklet.part2.pdf"
fi
