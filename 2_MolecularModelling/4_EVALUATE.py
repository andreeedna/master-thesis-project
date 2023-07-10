## ---------------------------
##
## Script name: EVALUATE.py
##
## Purpose of script:
##      this script perform the evaluation of the model generated with mdoeller
##
## Usage:
##      python3 EVALUATE.py query.pdb
##
## Author: Andrea Ninni
##
## Copyright (c) Andrea Ninni, 2022
## Email: andrea.ninni@uniroma2.it
##
## ---------------------------

from modeller import *
from modeller.scripts import complete_pdb
import sys

log.verbose()    # request verbose output
env = Environ()
env.libs.topology.read(file='$(LIB)/top_heav.lib') # read topology
env.libs.parameters.read(file='$(LIB)/par.lib') # read parameters

# read model file
mdl = complete_pdb(env, sys.argv[1])

# Assess with DOPE:
s = Selection(mdl)   # all atom selection
s.assess_dope(output='ENERGY_PROFILE NO_REPORT', file=sys.argv[1].split('.')[0]+'.profile',
              normalize_profile=True, smoothing_window=15)
