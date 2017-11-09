#!/bin/bash

FILES=yaml_files/best_gen_*.yaml
OUTPATH=/eos/user/s/shtan/plotting/test/plots/

for f in $FILES
do
    ../../external/Plotter_distributions/bin/plotter $f $OUTPATH
done
