## DESCRIPTION:
#THIS SCRIPT TAKES AS INPUT THE ALIGNMENT TO PERFORM THE MODELLING OF THE QUERY SEQUENCE

## USAGE:
# python3 3_MODEL.py PDB-QUERY.ali > model.log

from modeller import *
from modeller.automodel import *
#from modeller import soap_protein_od
import sys

env = Environ()
model = sys.argv[1].split("-")[0].split(".")[0]
seq = sys.argv[1].split("-")[1].split(".")[0]

a = AutoModel(env, alnfile=sys.argv[1],
              knowns=model, sequence=seq,
              assess_methods=(assess.DOPE,
                              #soap_protein_od.Scorer(),
                              assess.GA341))
a.starting_model = 1
a.ending_model = 5
a.make()
