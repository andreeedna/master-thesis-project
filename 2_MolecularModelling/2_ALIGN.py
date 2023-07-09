## DESCRIPTION:
#THIS SCRIPT TAKES AS INPUT THE PDB OF TEMPLATE AND THE SEQUENCE (in ALI format)
#TO PERFORM THE ALIGNMENT WITH MODELLER

#PDB Template: 5ldw.pdb (chain N)
#Sequence: ND2_Caretta.ali

## USAGE:
# python3 2_ALIGN.py PDB chain sequence.ali > align.log

# python3 2_ALIGN.py 5ldw N ND2_Caretta.ali > align.log

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
