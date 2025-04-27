#!/bin/bash

if [[ "$#" -lt 2 ]]
then
echo "Expected: input_dir output_dir [--max_depth N]"
exit 1
fi 

input_dir="$1"
output_dir="$2"

if [[ ! -d "$input_dir" ]]
then
echo "There is no input directory with name $input_dir"
exit 1
fi

mkdir -p "$output_dir"

if [[ "$3" == "--max_depth" ]]
then
    if [[ -z "$4" ]]
    then
    echo "Error: a number for --max_depth is needed"
    exit 1
    fi
max_depth="$4"
fi

find "$input_dir" -maxdepth "$max_depth" -type f -print0 | while IFS= read -r -d '' path
do 
name=$(basename "$path")
output_path="$output_dir/$name"

cntr=1
    while [[ -e "$output_path" ]]
    do
    rep_name="${name%.*}${cntr}${name##*.}"
    output_path="$output_dir/$rep_name"
    ((cntr++))
    done
cp "$path" "$output_path"
done



