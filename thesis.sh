#!/bin/bash

TYPE="$(basename "$0" .sh)"
INPUT_DIR="${1%/}"
OUTPUT_FILE_SUFFIX="${2:-latest}"
OUTPUT_DIR_SUFFIX="${3:-${INPUT_DIR##*/}}"
OUTPUT_DIR="pdf/${OUTPUT_DIR_SUFFIX}"

mkdir -p "$OUTPUT_DIR"

echo "===> Building: type: $TYPE, input_dir: $INPUT_DIR, output_dir: $OUTPUT_DIR, output_file_suffix: $OUTPUT_FILE_SUFFIX"
echo "===> Running: make pdf"
echo ""
echo ""
echo "============================================================================================================================="
echo ""
echo ""

TYPE="$TYPE" INPUT_DIR="$INPUT_DIR" OUTPUT_DIR="$OUTPUT_DIR" OUTPUT_FILE_SUFFIX="$OUTPUT_FILE_SUFFIX" make pdf
