[![Operations Research Journal Logo](https://orjournal.github.io/OperationsReseachHeader.jpg)](https://pubsonline.informs.org/journal/opre)

# cuPDLP.jl: A GPU Implementation of Restarted Primal-Dual Hybrid Gradient for Linear Programming in Julia

This archive is distributed in association with the journal [Operations Research](https://pubsonline.informs.org/journal/opre) under the [MIT License](LICENSE).

The software in this repository is a snapshot of the software that was used in the research reported in the paper [cuPDLP.jl: A GPU Implementation of Restarted Primal-Dual Hybrid Gradient for Linear Programming in Julia]() by Haihao Lu and Jinwen Yang.

## Cite

To cite the contents of this repository, please cite both the paper and this repo, using their respective DOIs.

## Description

The goal of this repository is to replicate the numerical experiments in the paper "cuPDLP.jl: A GPU Implementation of Restarted Primal-Dual Hybrid Gradient for Linear Programming in Julia" by Haihao Lu and Jinwen Yang.

## Setup

Before running the experiments, ensure that the required packages are installed on your local machine. Follow the instructions below for a one-time setup.

```shell
$ julia --project -e 'import Pkg; Pkg.instantiate()'
```

OR-Tools/PDLP is used through its Python interface. OR-Tools can be installed as follows:
```shell
$ python -m pip install ortools
```

A valid license is required to use Gurobi. See [here](https://www.gurobi.com/academia/academic-program-and-licenses/) for an academic license.

## Benchmarking
The repository includes scripts to download and prepare benchmark datasets required for numerical experiments. Refer to the detailed instructions in the `./benchmark` directory for setting up the datasets.


## Running Experiments

The following commands assume the repository's root directory as the working directory. The scripts are located in the `./scripts` folder, the source code for the algorithms and methods developed in the paper are located in the `./src` folder.

### Run All Instances

To run all instances across solvers and summarize results, use the script:
```shell
$ ./scripts/run_all.sh \
MIPLIB_INSTANCE_DIR \
MITTELMANN_INSTANCE_DIR \
MIPLIB_OUTPUT_DIR \
MITTELMANN_OUTPUT_DIR
```

### Run instances by solver
Below are the commands to run instances for individual solvers.
#### cuPDLP
```shell
$ ./scripts/run_cuPDLP_miplib.sh \
MIPLIB_INSTANCE_DIR \
MIPLIB_OUTPUT_DIR

$ ./scripts/run_cuPDLP_mittelmann.sh \
MITTELMANN_INSTANCE_DIR \
MITTELMANN_OUTPUT_DIR
```

#### Gurobi
```shell
$ ./scripts/run_Gurobi_miplib.sh \
MIPLIB_INSTANCE_DIR \
MIPLIB_OUTPUT_DIR

$ ./scripts/run_Gurobi_mittelmann.sh \
MITTELMANN_INSTANCE_DIR \
MITTELMANN_OUTPUT_DIR
```

#### PDLP (Julia and C++)
```shell
$ ./scripts/run_FirstOrderLp_miplib.sh \
MIPLIB_INSTANCE_DIR \
MIPLIB_OUTPUT_DIR

$ ./scripts/run_FirstOrderLp_mittelmann.sh \
MITTELMANN_INSTANCE_DIR \
MITTELMANN_OUTPUT_DIR
```

```shell
$ ./scripts/run_PDLP_miplib.sh \ 
MIPLIB_INSTANCE_DIR \
MIPLIB_OUTPUT_DIR

$ ./scripts/run_PDLP_mittelmann.sh \
MITTELMANN_INSTANCE_DIR \
MITTELMANN_OUTPUT_DIR
```

### Run individual instances
To run a single instance with specific configurations, use the following commands:
#### cuPDLP 
```shell
$ julia --project scripts/run_cuPDLP.jl \
--problem_name=PROBLEM_NAME \
--problem_folder=PROBLEM_FOLDER \
--output_directory=OUTPUT_DIRECTORY \
--tolerance=TOLERANCE \
--time_sec_limit=TIME_SEC_LIMIT
```

#### Gurobi
```shell
$ julia --project scripts/run_Gurobi.jl \
--problem_name=PROBLEM_NAME \
--problem_folder=PROBLEM_FOLDER \
--output_directory=OUTPUT_DIRECTORY \
--tolerance=TOLERANCE \
--time_sec_limit=TIME_SEC_LIMIT \
--gurobi_presolve=USE_PRESOLVE \
--gurobi_method=GUROBI_METHOD \
--gurobi_threads=GUROBI_THREADS
```

#### PDLP (Julia and C++)
```shell
$ julia --project scripts/run_FirstOrderLp.jl \
--problem_name=PROBLEM_NAME \
--problem_folder=PROBLEM_FOLDER \
--output_directory=OUTPUT_DIRECTORY \
--tolerance=TOLERANCE \
--time_sec_limit=TIME_SEC_LIMIT
```

```shell
$ python scripts/run_PDLP.py \
--problem_name=PROBLEM_NAME \
--problem_folder=PROBLEM_FOLDER \
--output_directory=OUTPUT_DIRECTORY \
--high_accuracy=USE_HIGH_ACCURACY \
--time_sec_limit=TIME_SEC_LIMIT \
--num_threads=NUM_THREADS \       
```

## Ongoing Development

This code is being developed on an on-going basis at the author-maintained
[cuPDLP.jl](https://github.com/jinwen-yang/cuPDLP.jl) Julia package.

## Support

For support in using this software, submit an
[issue](https://github.com/jinwen-yang/cuPDLP.jl/issues/new) here.
