# Tfrobot batch deployer

This repo contains some scripts for running batches of deployments using [tfrobot](https://github.com/threefoldtech/tfgrid-sdk-go/tree/development/tfrobot).

To start, edit the base config file. At least a mnemonic and ssh key should be filled in. The groups and vms can also be edited. This file represents a tempalte for a single batch. The scripts are hardcoded to deploy ten batches from the template, but that can easily be changed.

Once the base config is set, generate the ten config files:

```
./make_confs.sh
```

Then deploy them:

```
./deploy.sh
```

To cancel:

```
./cancel.sh
```

## Ping

There's also a script to ping the VMs over Mycelium in parallel using `fping`. During deployment the deployment script aggregates all the outputs to `all_outputs.yaml`. Pass this to the ping script and it will extract the Mycelium IP addresses:

```
./fping_mycelium.sh < all_outputs.yaml
```

## Map

The `map.py` file generates a map of the locations of all nodes that have an active deployment for a given twin or twins. You can use this to generate a map of your deployments:

```
python3 map.py <twin id>
```
