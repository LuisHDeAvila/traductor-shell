#!/bin/bash
: '
author : eleAche    
title: traductor para terminal
description:  haciendo uso de la utilidad pdftotext y trans (translate-shell)
              es una serie de comandos que suelo introducir de forma manual
              y ahora quiero convertirlo a un script para automatizar este proceso
              repetitivo, pues se puede obtener mucho contenido educativo de
              archivos .pdf; Usando google dorks, por ejemplo, haciendo la siguiente consulta: 
                >_ "libro informatica" filetype:pdf
              o usando metagoofil:
                >_ metagoofil -d nmap.org -t pdf -l 200 -n 10 -o /tmp/ -f /tmp/resultados_mgf.html
              y con esto poder romper las barreras del idioma, y asi poder aumentar
              el numero de personas que llegan a ser verdaderamente habiles
              en el area que se desenvuelvan.
requirements:   
'
# pdftotext
if [ ! `pdftotext -V cd` ]; then
  apt-get -y install pdftotext || pacman -Sy pdftotext || echo 'Hay que ser root'
fi
# translate-shell
if [ ! `trans -V cd` ]; then
  apt-get -y install translate-shell || pacman -Sy translate-shell || echo 'Hay que ser root'
fi
: ' 
se ejecuta en el directorio, enlista los archivos
filtro por extension .pdf
filtro por magicnumber correspondiente ( file -l )
obten la lista de archivos validos (operandos)

'
ls ~/textfiles || mkdir ~/textfiles
declare WORKDIR="~/textfiles"
cp *.pdf ~/textfiles;
cd ~/textfiles
for (( Listade=1; Listade++; Listade<73 )); do
    pdftotext $Listade.pdf $Listade.txt
    echo $Listade
done
rm -r *.pdf
# echo `pwd` | cd;
#echo "`ls | grep '.pdf'`" | awk -F. '{print $1}' | grep -n '' > $WORKDIR\/history.txt

#for file in *.pdf; do mv $file $file.pdf; done

#cat $WORKDIR\/history.txt | while read line; do
#  echo $line > $WORKDIR/STACKFILE
#done