# 2024.1069

This repository contains code to reproduce the numerical experiments in the paper. 

## Setup

Before running the experiments, ensure that the required packages are installed on your local machine. Follow the instructions below for a one-time setup.

```shell
$ julia --project -e 'import Pkg; Pkg.instantiate()'
```

OR-Tools/PDLP is used through its Python interface. OR-Tools can be installed as follows:
```shell
$ python -m pip install ortools
```

## Benchmarking
The repository includes scripts to download and prepare benchmark datasets required for numerical experiments. Refer to the detailed instructions in the `./benchmark` directory for setting up the datasets.


## Running the Experiments

The following commands assume the repository's root directory as the working directory.

### Run All Instances

To run all instances across solvers, use the script:
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