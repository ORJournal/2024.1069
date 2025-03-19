#!/bin/bash

if [[ "$#" != 4 ]]; then
  echo "Usage: run.sh miplib_instance_folder mittelmann_instance_folder miplib_output_directory mittelmann_output_directory" 1>&2
  exit 1
fi

MIPLIB_INSTANCE_DIR="$1"
MITTELMANN_INSTANCE_DIR="$2"
MIPLIB_OUTPUT_DIR="$3"
MITTELMANN_OUTPUT_DIR="$4"

echo '*********************** CUPDLP ***********************'
./run_cuPDLP_miplib.sh ${MIPLIB_INSTANCE_DIR} ${MIPLIB_OUTPUT_DIR}
./run_cuPDLP_mittelmann.sh ${MITTELMANN_INSTANCE_DIR} ${MITTELMANN_OUTPUT_DIR}
./run_cuPDLP_miplib_presolved.sh ${MIPLIB_INSTANCE_DIR} ${MIPLIB_OUTPUT_DIR}
./run_cuPDLP_mittelmann_presolved.sh ${MITTELMANN_INSTANCE_DIR} ${MITTELMANN_OUTPUT_DIR}
echo '*********************** CUPDLP DONE ***********************'
echo

echo '*********************** FIRSTORDERLP ***********************'
./run_FirstOrderLp_miplib.sh ${MIPLIB_INSTANCE_DIR} ${MIPLIB_OUTPUT_DIR}
./run_FirstOrderLp_mittelmann.sh ${MITTELMANN_INSTANCE_DIR} ${MITTELMANN_OUTPUT_DIR}
echo '*********************** FIRSTORDERLP DONE ***********************'
echo

echo '*********************** PDLP ***********************'
./run_PDLP_miplib.sh ${MIPLIB_INSTANCE_DIR} ${MIPLIB_OUTPUT_DIR}
./run_PDLP_mittelmann.sh ${MITTELMANN_INSTANCE_DIR} ${MITTELMANN_OUTPUT_DIR}
echo '*********************** PDLP DONE ***********************'
echo

echo '*********************** GUROBI ***********************'
./run_Gurobi_miplib.sh ${MIPLIB_INSTANCE_DIR} ${MIPLIB_OUTPUT_DIR}
./run_Gurobi_mittelmann.sh ${MITTELMANN_INSTANCE_DIR} ${MITTELMANN_OUTPUT_DIR}
echo '*********************** GUROBI DONE ***********************'
echo

echo '*********************** RESULTS ***********************'
echo
echo '*********************** MIPLIB ***********************'
echo
julia --project summarize_result_miplib.jl \
      --tolerance=1e-4 \
      --output_directory="${MIPLIB_OUTPUT_DIR}"
echo
julia --project summarize_result_miplib.jl \
      --tolerance=1e-8 \
      --output_directory="${MIPLIB_OUTPUT_DIR}"
echo
echo '*********************** MIPLIB DONE ***********************'
echo

echo
echo '*********************** MITTELMANN ***********************'
echo
julia --project summarize_result_mittelmann.jl \
      --tolerance=1e-4 \
      --output_directory="${MITTELMANN_OUTPUT_DIR}"
echo
julia --project summarize_result_mittelmann.jl \
      --tolerance=1e-8 \
      --output_directory="${MITTELMANN_OUTPUT_DIR}"
echo
echo '*********************** MITTELMANN DONE ***********************'
echo


echo
echo '*********************** FINISHED ***********************'
echo

