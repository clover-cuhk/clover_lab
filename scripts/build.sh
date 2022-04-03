#!/bin/bash

build_urdf() {

  xacro_dir="../xacro"
  urdf_dir="../urdf"

  if [ -d $xacro_dir ]; then
    echo "==== Building: $1 | Simulator: $2 ===="

    if [ "$2" == "none" ]; then
      xacro $xacro_dir/"$1".urdf.xacro simulator:="$2" >$urdf_dir/"$1".urdf
      check_urdf $urdf_dir/"$1".urdf
    else
      xacro $xacro_dir/"$1".urdf.xacro simulator:="$2" >$urdf_dir/"$1"_"$2".urdf
      check_urdf $urdf_dir/"$1"_"$2".urdf
    fi

  else
    echo "ERROR: The xacro directory $xacro_dir does not exist."
    exit 1
  fi
}

## Get current folder and make sure it is *scripts*
curr_folder=${PWD##*/}
if [ "$curr_folder" != "scripts" ]; then
  echo "ERROR: you need to run the script from the clover_lab/scripts directory."
  echo "$curr_folder"
  exit 1
fi

#models=("clover_lab" "base_cabinet" "wall_cabinet")
models=("clover_lab")

for model in "${models[@]}"; do

  build_urdf "$model" none
  build_urdf "$model" mujoco

done

exit 0
