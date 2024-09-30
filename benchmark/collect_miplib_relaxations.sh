#!/bin/bash

if [[ "$#" != 3 ]]; then
  echo "Usage: collect_miplib_relaxations.sh temporary_dir" \
      "miplib_relaxations_instances_list output_directory" 1>&2
  exit 1
fi

TEMP_DIR="$1"
INSTANCE_FILE="$2"
DEST_DIR="$3"

mkdir -p "${TEMP_DIR}" || exit 1
mkdir -p "${DEST_DIR}" || exit 1

readarray -t instances < <(egrep -v '^#' "${INSTANCE_FILE}")
declare -a filenames
for instance in "${instances[@]}"; do
  filenames+=("${instance}.mps.gz")
done

wget --directory-prefix="${TEMP_DIR}" \
  https://miplib.zib.de/downloads/collection.zip || exit 1

unzip -d "${DEST_DIR}" "${TEMP_DIR}/collection.zip" "${filenames[@]}" || exit 1

rm "${TEMP_DIR}/collection.zip"