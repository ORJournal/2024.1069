#!/bin/bash

if [[ "$#" != 1 ]]; then
  echo "Usage: collect_mittelmann_lp.sh instance_folder" 1>&2
  exit 1
fi

DEST_DIR="$1"

for f in a2864 datt256_lp dlr1 ex10 fhnw-binschedule1 graph40-40 irish-electricity neos-3025225 neos-5052403-cygnet neos-5251015 physiciansched3-3 qap15 rmine15 s82 s100 s250r10 savsched1 scpm1 square41 supportcase10 tpl-tub-ws1617 woodlands09 Dual2_5000 Primal2_1000 thk_48 thk_63 L2CTA3D dlr2 set-cover-model; do
  wget -nv -O - "http://plato.asu.edu/ftp/lptestset/${f}.mps.bz2" | bzcat | \
       gzip > "${DEST_DIR}/${f}.mps.gz"
done

wget -nv -O - "http://plato.asu.edu/ftp/lptestset/neos-5052403-cygnet.mps.bz2" | bzcat | \
       gzip > "${DEST_DIR}/neos-5052403-cygnet.mps.gz"

for f in L1_sixm250obs Linf_520c bdry2 L1_sixm1000obs; do
  wget -nv -O - "http://plato.asu.edu/ftp/lptestset/${f}.bz2" | bzcat | \
      "./emps" | gzip > "${DEST_DIR}/${f}.mps.gz"
done

for f in misc/cont1 misc/cont11 fome/fome13 misc/neos misc/neos3 misc/ns1687037 misc/ns1688926 nug/nug08-3rd pds/pds-100 rail/rail4284 misc/stormG2_1000; do
  instance="$(basename $f)"
  wget -nv -O - "http://plato.asu.edu/ftp/lptestset/${f}.bz2" | bzcat | \
      "./emps" | gzip > "${DEST_DIR}/${instance}.mps.gz"
done

wget -nv -O - "http://old.sztaki.hu/~meszaros/public_ftp/lptestset/New/degme.gz" > "${DEST_DIR}/degme.mps.gz"

wget -nv -O - "http://old.sztaki.hu/~meszaros/public_ftp/lptestset/misc/stat96v2.gz" > "${DEST_DIR}/stat96v2.mps.gz"

wget -nv -O - "https://miplib2010.zib.de/download/rail02.mps.gz" > "${DEST_DIR}/rail02.mps.gz"

wget -nv -O - "https://miplib2010.zib.de/download/stp3d.mps.gz" > "${DEST_DIR}/stp3d.mps.gz"

INSTANCE_LIST="a2864 bdry2 cont11 cont1 datt256_lp degme dlr1 dlr2 Dual2_5000 ex10 fhnw-binschedule1 fome13 graph40-40 irish-electricity L1_sixm1000obs L1_sixm250obs L2CTA3D Linf_520c neos-3025225 neos3 neos-5052403-cygnet neos-5251015 neos ns1687037 ns1688926 nug08-3rd pds-100 physiciansched3-3 Primal2_1000 qap15 rail02 rail4284 rmine15 s100 s250r10 s82 savsched1 scpm1 set-cover-model shs1023 square41 stat96v2 stormG2_1000 stp3d supportcase10 thk_48 thk_63 tpl-tub-ws1617 woodlands09"

for lp in ${INSTANCE_LIST}
do
    gzip -dkc < ${DEST_DIR}/${lp}.mps.gz > ${DEST_DIR}/${lp}.mps
    echo 
done
