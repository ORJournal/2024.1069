#!/bin/bash

if [[ "$#" != 2 ]]; then
  echo "Usage: run_PDLP_mittelmann.sh instance_folder output_directory" 1>&2
  exit 1
fi

INSTANCE_DIR="$1"
OUTPUT_DIR="$2"

INSTANCE_LIST="a2864 bdry2 cont11 cont1 datt256_lp degme dlr1 dlr2 Dual2_5000 ex10 fhnw-binschedule1 fome13 graph40-40 irish-electricity L1_sixm1000obs L1_sixm250obs L2CTA3D Linf_520c neos-3025225 neos3 neos-5052403-cygnet neos-5251015 neos ns1687037 ns1688926 nug08-3rd pds-100 physiciansched3-3 Primal2_1000 qap15 rail02 rail4284 rmine15 s100 s250r10 s82 savsched1 scpm1 set-cover-model shs1023 square41 stat96v2 stormG2_1000 stp3d supportcase10 thk_48 thk_63 tpl-tub-ws1617 woodlands09"

echo
echo '*********************** LOW ACCURACY ***********************'
echo
for lp in ${INSTANCE_LIST}
do
    echo ${lp}
    echo '*********************** 1 THREAD ***********************'
    python run_PDLP.py \
           --problem_name=${lp} \
           --time_sec_limit=15000 \
           --num_threads=1 \
           --problem_folder=${INSTANCE_DIR} \
           --output_directory=${OUTPUT_DIR} \
           --high_accuracy=0
    echo 

    echo '*********************** 4 THREADS ***********************'
    python run_PDLP.py \
           --problem_name=${lp} \
           --time_sec_limit=15000 \
           --num_threads=4 \
           --problem_folder=${INSTANCE_DIR} \
           --output_directory=${OUTPUT_DIR} \
           --high_accuracy=0
    echo 

    echo '*********************** 16 THREADS ***********************'
    python run_PDLP.py \
           --problem_name=${lp} \
           --time_sec_limit=15000 \
           --num_threads=16 \
           --problem_folder=${INSTANCE_DIR} \
           --output_directory=${OUTPUT_DIR} \
           --high_accuracy=0
    echo 
done

echo
echo '*********************** HIGH ACCURACY ***********************'
echo
for lp in ${INSTANCE_LIST}
do
    echo ${lp}
    echo '*********************** 1 THREAD ***********************'
    python run_PDLP.py \
           --problem_name=${lp} \
           --time_sec_limit=15000 \
           --num_threads=1 \
           --problem_folder=${INSTANCE_DIR} \
           --output_directory=${OUTPUT_DIR} \
           --high_accuracy=1
    echo 

    echo '*********************** 4 THREADS ***********************'
    python run_PDLP.py \
           --problem_name=${lp} \
           --time_sec_limit=15000 \
           --num_threads=4 \
           --problem_folder=${INSTANCE_DIR} \
           --output_directory=${OUTPUT_DIR} \
           --high_accuracy=1
    echo 

    echo '*********************** 16 THREADS ***********************'
    python run_PDLP.py \
           --problem_name=${lp} \
           --time_sec_limit=15000 \
           --num_threads=16 \
           --problem_folder=${INSTANCE_DIR} \
           --output_directory=${OUTPUT_DIR} \
           --high_accuracy=1
    echo 
done

echo
echo '*********************** FINISHED ***********************'
echo