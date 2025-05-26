#!/bin/sh
# MIT License

# Copyright (c) 2024 Haihao Lu, Jinwen Yang

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

if [[ "$#" != 1 ]]; then
  echo "Usage: presolve_mittelmann_lp.sh instance_folder" 1>&2
  exit 1
fi

INSTANCE_DIR="$1"

INSTANCE_LIST="a2864 bdry2 cont11 cont1 datt256_lp degme dlr1 dlr2 Dual2_5000 ex10 fhnw-binschedule1 fome13 graph40-40 irish-electricity L1_sixm1000obs L1_sixm250obs L2CTA3D Linf_520c neos-3025225 neos3 neos-5052403-cygnet neos-5251015 neos ns1687037 ns1688926 nug08-3rd pds-100 physiciansched3-3 Primal2_1000 qap15 rail02 rail4284 rmine15 s100 s250r10 s82 savsched1 scpm1 set-cover-model shs1023 square41 stat96v2 stormG2_1000 stp3d supportcase10 thk_48 thk_63 tpl-tub-ws1617 woodlands09"

for lp in ${INSTANCE_LIST}
do
    echo ${lp}
    julia --project presolve_instances.jl \
          --problem_name=${lp} \
          --problem_folder="${INSTANCE_DIR}" \
          --output_directory="${INSTANCE_DIR}"
    echo 
done

echo
echo '*********************** FINISHED ***********************'
echo