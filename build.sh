#!/bin/bash

run_make_pdf() {
    echo "===> ARGS - 1: $TYPE (TYPE) 2: $INPUT_DIR (INPUT_DIR), 3: $OUTPUT_FILE_SUFFIX (OUTPUT_FILE_SUFFIX), 4: $OUTPUT_DIR_SUFFIX (OUTPUT_DIR_SUFFIX)"
    echo "===> Defaults - 3: latest, 4: From INPUT_DIR"
    echo "===> Makefile ENV - type: $TYPE, input_dir: $INPUT_DIR, output_dir: $OUTPUT_DIR, output_file_suffix: $OUTPUT_FILE_SUFFIX"
    echo "===> Running: make pdf"
    echo ""
    echo ""
    echo "============================================================================================================================="
    echo ""
    echo ""

    mkdir -p "$OUTPUT_DIR"
    TYPE="$TYPE" INPUT_DIR="$INPUT_DIR" OUTPUT_DIR="$OUTPUT_DIR" OUTPUT_FILE_SUFFIX="$OUTPUT_FILE_SUFFIX" FEW="$FEW" make pdf
}

TASK_TYPE="$1"
BASE_INPUT_DIR="${2%/}"
FEW=false

if [[ "$TASK_TYPE" == "few" ]]; then
    FEW=true

    TYPES_ARRAY=()
    while IFS= read -r -d '' dir; do
        if [[ "$(basename "$dir")" != "assets" ]]; then
            TYPES_ARRAY+=("$(basename "$dir")")
        fi
    done < <(find "$BASE_INPUT_DIR" -mindepth 1 -maxdepth 1 -type d -print0)

    for TYPE in "${TYPES_ARRAY[@]}"; do
        INPUT_DIR="${BASE_INPUT_DIR}/${TYPE}"
        OUTPUT_FILE_SUFFIX="${3:-latest}"
        OUTPUT_DIR_SUFFIX="${4:-${BASE_INPUT_DIR##*/}}"
        OUTPUT_DIR="pdf/${OUTPUT_DIR_SUFFIX}"

        run_make_pdf
    done
else
    TYPE="$TASK_TYPE"
    INPUT_DIR="${BASE_INPUT_DIR}"
    OUTPUT_FILE_SUFFIX="${3:-latest}"
    OUTPUT_DIR_SUFFIX="${4:-${INPUT_DIR##*/}}"
    OUTPUT_DIR="pdf/${OUTPUT_DIR_SUFFIX}"

    run_make_pdf
fi
