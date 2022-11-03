#!/usr/bin/bash
# use the var of environment $TMPDIR
TEMPORALSCRIPT=$(mktemp)
TMPDIR=$(mktemp -d)
OUTPUTDIR=~/translations
[[ -d $OUTPUTDIR ]] || mkdir $OUTPUTDIR
echo $TMPDIR

find . | grep 'txt$' | while read line; do
  let c++
  cp "$line" $TMPDIR
  echo -en "agregando ficheros a espacio de trabajo: ${c}\r"
done

function prompt_log(){
	echo -e "\e[34m traduciendo -> ${1::20}\e[m"

	echo -e "\e[33m finalizado -> ${1::20}\e[m"

	mv "${1%.txt}_es.txt" "$OUTPUTDIR"
}

# main function
cat << 'EOF' > $TEMPORALSCRIPT
trans -b :es -input "$1" -output "$1_es.txt"
EOF

cd $TMPDIR
ls
cat $TEMPORALSCRIPT
parallel bash $TEMPORALSCRIPT -- *.txt 2>/dev/null
rm $TEMPORALSCRIPT
mv *_es.txt $OUTPUTDIR
echo "Done."
exit 0
