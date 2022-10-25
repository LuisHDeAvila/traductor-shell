#!/usr/bin/env bash
: '
	Se tiene una coleccion de ficheros pdfs en idiomas desconocidos, y se quiere extraer y organizar el contenido para su revision.
	Revision mediante procesamiento de lenguaje natural.
'
[[ -d data ]] && echo "atencion: directorio /data/ esta presente y todo dentro de el sera ignorado"
function pre_ejecution(){
local enumeracion=$(find . | grep 'pdf$' | grep -v '/data' | wc -l)
echo "Se encontraron $enumeracion ficheros para procesar"
}

pre_ejecution
read -p " presiona [ENTER] para continuar " CONSENTIMIENTO
# renombrar con los siguientes criterios: el nombre solo contiene letras en minusculas y/o numeros.
function renombrarficheros(){
	[[ -d data ]] || mkdir data
	find . | grep 'pdf$' | while read line
	do
		local name=$(echo "$line"\
				| awk -F/ '{print $NF}'\
				| sed 's/\.pdf//g'\
				| grep -Eo '[a-zA-Z0-9]+'\
				| tr '\n' ' '\
				| sed 's/ //g'\
				| tr [:upper:] [:lower:] );
		# testing
    	echo "  [ $name.pdf ]  <=  [ ${line::30} ]"

		# depositar copia renombrada
    	cp "$line" "data/$name.pdf"

	done
}

function caracteristicas(){
cat << EOF
	{
		id: $1,
		fichero: "$2",
		caracteristicas: [
			lineas: $3,
			caracteres: $4
		],
		traduccion: "$5"
	},
EOF
}

renombrarficheros && cd data

function convertirpdfsatexto(){
ls *.pdf | while read line; do
	pdftotext "$line"
done
}

function preparar-revision(){
local database=Traducciones.json
echo "  traducciones: [" > $database

ls *.txt | while read fichero; do
	echo $fichero
done 2>/dev/null

echo "];" >> $database
}