## ---------------------------
##
## Script name: MUTASEQUENZA.py
##
## Purpose of script:
##      this script take a file text with only the sequence and print the
##	mutated sequence (used for FoldX)
##
## Usage:
##      python3 MUTASEQUENZA.py file_name mut1 mut2 mut3...
##
## Author: Andrea Ninni
##
## Copyright (c) Andrea Ninni, 2022
## Email: andrea.ninni@uniroma2.it
##
## ---------------------------
##
## Notes:
##      the mutation format must be xxxNxxx
##      example: Ala103Thr
##
## ---------------------------


import sys

aminos={'Cys': 'C', 'Asp': 'D', 'Ser': 'S', 'Gln': 'Q', 'Lys': 'K','Ile': 'I','Pro': 'P',
	'Thr': 'T', 'Phe': 'F', 'Asn': 'N','Gly': 'G', 'His': 'H', 'Leu': 'L', 'Arg': 'R',
	'Trp': 'W','Ala': 'A', 'Val':'V', 'Glu': 'E', 'Tyr': 'Y', 'Met': 'M'}

with open(sys.argv[1]) as f:
	line = f.readline()
	seq=''
	while(line):
		seq = seq + line.strip()
		line = f.readline()

sequence=list(seq)

for mut in sys.argv[2:]:
	aa_wt = aminos[mut[0:3]]
	aa_mut = aminos[mut[-3:]]
	pos = int(mut[3:-3])
	if sequence[pos-1] == aa_wt:
		sequence[pos-1]=aa_mut
	else:
		sys.exit("ERROR: the mutation " + mut + "is not congruent with the sequence provided")

print(''.join(sequence))
