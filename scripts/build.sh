#!/bin/bash

robot=base_cabinet

build_urdf() {

  xacro_dir="../xacro"
  urdf_dir="../urdf"

  if [ -d $xacro_dir ]; then
    echo "==== Building: $robot | Simulator: $1 ===="

    if [ "$1" == "none" ]; then
      xacro $xacro_dir/$robot.urdf.xacro simulator:="$1" >$urdf_dir/"$robot".urdf
      check_urdf $urdf_dir/$robot.urdf
    else
      xacro $xacro_dir/$robot.urdf.xacro simulator:="$1" >$urdf_dir/"$robot"_"$1".urdf
      check_urdf $urdf_dir/"$robot"_"$1".urdf
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

build_urdf none

exit 0
