#!/usr/bin/env bash
: '
  para procesar muchos archivos, crear un directorio "analyst-pln", y entra a ese directorio.
  luego crea un directorio "data" donde almacenaras todos los ficheros que vas a procesar.
  La primera funcion renombra ficheros, esto para facilitar el procesamiento masivo.
  
'

# si data es un directorio, entra al directorio data, si data no es un directorio, finaliza.
[[ -d data ]] && cd data || exit 0

# funciones de mantenimiento
function indicacionesparausar() {
local thisscript=$0
cat << INDICACIONES
si testing es correcto, ejecuta el siguiente comando: sed -i 's/# mv \"$line\"/mv \"$line\"/g' $thisscript"
INDICACIONES
}

# renombrar con los siguientes criterios: el nombre solo contiene letras en minusculas y/o numeros.
function renombrarficheros(){
	ls | while read line
	do
		local name=$(echo "$line" \
				| sed 's/\.pdf//g' \
				| grep -Eo '[a-zA-Z0-9]+' \
				| tr '\n' ' ' \
				| sed 's/ //g' \
				| tr [:upper:] [:lower:] );
		# testing
    echo "  [ $name.pdf ]  <=  [ ${line::30} ]"

    # mv "$line" "$name.pdf"
	done
}

# guarda nombres de ficheros renombrados en un array
for book in $( ls )
do
	Books+=("$book")
done # echo "${Books[@]}"

# crea un breve reporte de los ficheros
function reporte() {
	local Reporte=$(echo "${Books[@]}" | tr ' ' '\n' | wc -l)
  echo " Hay $Reporte listos para procesar"
}

reporte
