## ---------------------------
##
## Script name: ALIGN.py
##
## Purpose of script:
##      this script take as input the pdb og f template and the sequence (in ALI format)
##      to perform the alignment wirh modeller
##
## Usage:
##	python3 ALIGN.py PDB chain sequence.ali > align.log
##
## Author: Andrea Ninni
##
## Copyright (c) Andrea Ninni, 2022
## Email: andrea.ninni@uniroma2.it
##
## ---------------------------
##
## Notes:
##	PDB Template: 5ldw.pdb (chain N)
##	Sequence: Caretta_ND2.ali
##	python3 2_ALIGN.py 5ldw N ND2_Caretta.ali > align.log
##
## ---------------------------


import sys
from modeller import *

env = Environ()
aln = Alignment(env)

mdl = Model(env, file=sys.argv[1], model_segment=('FIRST:'+ sys.argv[2], 'LAST:'+sys.argv[2]))
aln.append_model(mdl, align_codes = sys.argv[1], atom_files=sys.argv[1]+'.pdb')
aln.append(file=sys.argv[3]+'.ali', align_codes=sys.argv[3])
aln.align2d()
aln.describe()
aln.write(file=sys.argv[1]+'-'+sys.argv[3]+'.ali', alignment_format='PIR')
aln.write(file=sys.argv[1]+'-'+sys.argv[3]+'.pap', alignment_format='PAP')
aln.check()
