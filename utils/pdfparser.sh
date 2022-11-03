#!/bin/bash
find . | grep 'pdf$' | while read books
  do
	  newname=$(echo "$books" | awk -F/ '{print $NF}' | grep -Eo '[A-Za-z0-9]+' | tr '\n' ' ' |  sed 's/pdf//g' | sed 's/ /_/g')
	  echo $newname
done
