#!/bin/bash

TYPE="${1}"
INPUT_DIR="${2%/}"
OUTPUT_FILE_SUFFIX="${3:-latest}"
OUTPUT_DIR_SUFFIX="${4:-${INPUT_DIR##*/}}"
OUTPUT_DIR="pdf/${OUTPUT_DIR_SUFFIX}"

mkdir -p "$OUTPUT_DIR"

echo "===> ARGS - 1: $TYPE (TYPE) 2: $INPUT_DIR (INPUT_DIR), 3: $OUTPUT_FILE_SUFFIX (OUTPUT_FILE_SUFFIX), 4: $OUTPUT_DIR_SUFFIX (OUTPUT_DIR_SUFFIX)"
echo "===> Defaults - 3: latest, 4: From INPUT_DIR"
echo "===> Makefile ENV - type: $TYPE, input_dir: $INPUT_DIR, output_dir: $OUTPUT_DIR, output_file_suffix: $OUTPUT_FILE_SUFFIX"
echo "===> Running: make pdf"
echo ""
echo ""
echo "============================================================================================================================="
echo ""
echo ""

TYPE="$TYPE" INPUT_DIR="$INPUT_DIR" OUTPUT_DIR="$OUTPUT_DIR" OUTPUT_FILE_SUFFIX="$OUTPUT_FILE_SUFFIX" make pdf
