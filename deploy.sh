#!/bin/bash

for i in {1..10}; do
    tfrobot deploy -c "conf${i}.yaml"
    cat output.yaml >> all_outputs.yaml
done
