#!/bin/bash

TEMPLATE_DIR=templates/

template_best_gev=./${TEMPLATE_DIR}template_best_gev.yaml
template_smeared=./${TEMPLATE_DIR}template_smeared.yaml

template_best_angle=./${TEMPLATE_DIR}template_best_angle.yaml

FILES_path=/eos/user/s/shtan/plotting/test/
OUTPATH=yaml_files/

FILES_Pt="${FILES_path}best_gen_*_Pt.txt"
FILES_Phi="${FILES_path}best_gen_*_Phi.txt"
FILES_Eta="${FILES_path}best_gen_*_Eta.txt"
FILES_M="${FILES_path}best_gen_*_M.txt"

for f in $FILES_Pt $FILES_M
do
    echo "Processing $f file..."
    filename=$(basename "$f")
    filename_str="${filename%.*}"

    best_yaml_name="./${OUTPATH}${filename_str}.yaml"

    cp $template_best_gev $best_yaml_name

    sed -i -e "s?put_input_file_name_here?$f?g" $best_yaml_name

    prefix="best"
    tempsmearedname=${filename_str#$prefix}
    smeared_filename_str="smeared${tempsmearedname}"
    smeared_yaml_name="./${OUTPATH}smeared${tempsmearedname}.yaml"

    cp $template_smeared $smeared_yaml_name

    sed -i -e "s?put_extra_file_name_here?${OUTPATH}${smeared_filename_str}.yaml?g" $best_yaml_name

    sed -i -e "s?put_input_file_name_here?${FILES_path}${smeared_filename_str}.txt?g" $smeared_yaml_name

    chmod 755 $best_yaml_name
    chmod 755 $smeared_yaml_name
done

for f in $FILES_Phi $FILES_Eta
do
    echo "Processing $f file..."
    filename=$(basename "$f")
    filename_str="${filename%.*}"

    best_yaml_name="./${OUTPATH}${filename_str}.yaml"

    cp $template_best_angle $best_yaml_name

    sed -i -e "s?put_input_file_name_here?$filename?g" $best_yaml_name

    prefix="best"
    tempsmearedname=${filename_str#$prefix}
    smeared_filename_str="${OUTPATH}smeared${tempsmearedname}"
    smeared_yaml_name="./${OUTPATH}smeared${tempsmearedname}.yaml"

    cp $template_smeared $smeared_yaml_name

    sed -i -e "s?put_extra_file_name_here?${smeared_filename_str}.yaml?g" $best_yaml_name

    sed -i -e "s?put_input_file_name_here?${smeared_filename_str}.txt?g" $smeared_yaml_name

    chmod 755 $best_yaml_name
    chmod 755 $smeared_yaml_name
done
