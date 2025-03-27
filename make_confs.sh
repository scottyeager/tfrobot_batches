#!/bin/bash

for i in {1..10}; do
    cp base_conf.yaml "conf${i}.yaml"
    sed -i "s/everywhere/everywhere${i}/g" "conf${i}.yaml"
done
