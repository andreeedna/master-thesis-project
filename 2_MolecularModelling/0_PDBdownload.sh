#!/bin/bash

# Script to download pdb template files used

if ! command -v curl &> /dev/null
then
	echo "'curl' could no be found. You need to install 'curl' for this script to work"
	exit 1
fi

BASE_URL="https://files.rcsb.org/download"

mkdir TemplatesPDB

download() {
  url="$BASE_URL/$1"
  out="TemplatesPDB/$1"
  echo "Downloading $url"
  curl -s -f $url -o $out || echo "Failed to download $url"
}

pdbs=("6ZPO" "2OCC" "3H1I" "5LDW" "6G2J" "7V2D")

for tok in "${pdbs[@]}"
do
	download ${tok}.pdb
done
