#!/bin/bash

for i in {1..10}; do
    tfrobot cancel -c "conf${i}.yaml"
done
