#!/bin/bash

if [[ "$#" -lt 2 ]]
then
echo "Expected: input_dir output_dir [--max_depth N]"
exit 1
fi 

input_dir="$1"
output_dir="$2"
max_depth=-1

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
max_depth=$(( "$4" + 1 ))
fi

if [[ "$max_depth" -lt 0 ]]
then
find "$input_dir" -type f -print0 
else
find "$input_dir" -maxdepth "$max_depth" -type f -print0 
fi | while IFS= read -r -d '' path
do 
name=$(basename "$path")
output_path="$output_dir/$name"

cntr=1
dot="."
    while [[ -e "$output_path" ]]
    do
    rep_name="${name%.*}${cntr}${dot}${name##*.}"
    output_path="$output_dir/$rep_name"
    ((cntr++))
    done
cp "$path" "$output_path"
done



