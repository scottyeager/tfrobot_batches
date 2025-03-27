#!/bin/bash

# Clear any output from the last run
rm -f all_outputs.yaml

for i in {1..10}; do
    tfrobot deploy -c "conf${i}.yaml"
    cat output.yaml >> all_outputs.yaml
done
