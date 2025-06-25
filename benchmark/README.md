# Benchmarking

This directory contains scripts for generating benchmark datasets for cuPDLP.jl.

## Filtered MIP relaxations dataset

This dataset is curated from the MIPLIB 2017 collection, filtered as specified
in `miplib_relaxations_instances_list`. `collect_miplib_relaxations.sh` has the following argument structure:

```sh
$ ./collect_mip_relaxations.sh TEMPORARY_DIRECTORY BENCHMARK_INSTANCE_LIST INSTANCE_FOLDER
```

## Mittelmann's LP dataset

This dataset contains the union of the instances from Hans Mittelmann's linear programming benchmark sites, as specified in `mittelmann_lp_instances_list`. `collect_mittelmann_lp.sh` has the following argument structure:

```sh
$ ./collect_mittelmann_lp.sh INSTANCE_FOLDER
```
## Presolving
Instances presolved by Gurobi are extracted for both MIPLIB relaxation and Mittelmann's LP datasets. `presolve_miplib_relaxations.sh` and `presolve_mittelmann_lp.sh` have the following argument structure:
```sh
$ ./presolve_miplib_relaxations.sh INSTANCE_FOLDER
$ ./presolve_mittelmann_lp.sh INSTANCE_FOLDER
```