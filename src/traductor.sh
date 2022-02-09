#!/bin.bash
# author : eleAche
# title: traductor para terminal
# requirements:
PDFTOTEXT='pdftotext '
TRANS='translate-shell '
POPPLER='poppler '

if (( ${ls /usr/bin/share | grep -c $PDFTOTEXT } -eq 0 )); then
  pacman -Syy $PDFTOTEXT || pacman -Syy $PDFTOTEXT || apt-get install -y $POPPLER || apt-get install -y $POPPLER;
fi

if (( ${ls /usr/bin/share | grep -c $TRANSLATE-SHELL } -eq 0 )); then
  pacman -Syy $TRANS || apt-get install -y $TRANS;
fi

echo 'escribe la ruta al libro con extension .pdf  :'
read LIBRO
pdftotext $LIBRO libro.txt | trans -b :es
