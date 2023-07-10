## ---------------------------
##
## Script name: MODEL.py
##
## Purpose of script:
##      this script perform the modelling of the query sequence
##
## Usage:
##      python3 MODEL.py PDB-QUERY.ali > model.log
##
## Author: Andrea Ninni
##
## Copyright (c) Andrea Ninni, 2022
## Email: andrea.ninni@uniroma2.it
##
## ---------------------------


from modeller import *
from modeller.automodel import *
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
