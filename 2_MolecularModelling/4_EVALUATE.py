## DESCRIPTION:
#THIS SCRIPT PERFORM THE EVALUATION OF THE MODELS GENERATED WITH MODELLER

## USAGE:
# python3 4_EVALUATE.py query.pdb

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
