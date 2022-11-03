#!/bin/bash
# author: eleAche
# description: divide el contenido de un fichero de texto.
if [ `file "$1" | grep -c 'text'` -ne 0 ]
  then
	ENTRY="$1"
  else
	echo ' !! entrada no valida, se esperaba un archivo de texto !!' && exit
fi

# dividir total de lineas entre numero de partes (default: 10)
numberlines=$(wc -l $ENTRY | awk '{print $1}')
numberparts=10
BLOCK=$(echo $(( numberlines/numberparts )))

### remover u003d solo aplica al contexto de LaTex
# sed -i 's/u003d//g' $ENTRY #####################

for ((c=1;c<=$numberparts;c++))
  do
    let inicio=$(( BLOCK*c ))
    cat $ENTRY | head -$inicio | tail $BLOCK > PARTE$c.txt
done
