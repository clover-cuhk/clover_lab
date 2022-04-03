#!/bin/bash

version="200"
robot=clover_lab

build_mjcf() {
  cd .. || exit 1

  mujoco_compile="$HOME/.mujoco/mujoco$version/bin/compile"
  mujoco_simulate="$HOME/.mujoco/mujoco$version/bin/simulate"

  # Given a valid relative path, this command get its full path
  urdf_file="$(readlink -m "$1")"

  if [ -x "$mujoco_compile" ]; then

    if [ -f "$urdf_file" ]; then
      echo "==== Compiling: $robot ===="

      # Only copy the file when newer than the destination it does not exist
      cp -u "$urdf_file" "$robot"_mujoco.urdf
      rm -f "$robot"_raw_model.xml

      $mujoco_compile "$robot"_mujoco.urdf "$robot"_raw_model.xml
      $mujoco_simulate "$robot"_raw_model.xml

      rm -f MUJOCO_LOG.TXT

    else
      echo "ERROR: $urdf_file does not exist."
      exit 1
    fi
  else
    echo "ERROR: The executable $mujoco_compile does not exist."
    exit 1
  fi
}

## Get current folder and make sure it is *scripts*
curr_folder=${PWD##*/}
if [ "$curr_folder" != "scripts" ]; then
  echo "ERROR: you need to run the script from the 'scripts' directory."
  echo "$curr_folder"
  exit 1
fi

build_mjcf "./urdf/clover_lab_mujoco.urdf"

exit 0
