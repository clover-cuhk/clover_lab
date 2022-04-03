#!/bin/bash

version="200"
robot=curi

run_simulation() {

  mujoco_simulate="$HOME/.mujoco/mujoco$version/bin/simulate"
  mjcf_file="$(readlink -m "$1")"

  if [ -x "$mujoco_simulate" ]; then

    if [ -f "$mjcf_file" ]; then
      echo "==== Simulating: $robot ===="

      cd ../models || exit 1

      $mujoco_simulate "$mjcf_file"

      rm -f MUJOCO_LOG.TXT

    else
      echo "ERROR: $mjcf_file does not exist."
      exit 1
    fi
  else
    echo "ERROR: The executable $mujoco_simulate does not exist."
    exit 1
  fi
}

## Get current folder and make sure it is *scripts*
curr_folder=${PWD##*/}
if [ "$curr_folder" != "scripts" ]; then
  echo "ERROR: you need to run the script from the curi_mujoco/scripts directory."
  echo "$curr_folder"
  exit 1
fi

while getopts 't' flag ; do
    case $flag in
    t) use_torque_controlled='true' ;;
    *) use_torque_controlled='false' ;;
    esac
done

if [ $use_torque_controlled ]; then
  echo "Using torque controlled arms."
  run_simulation "../models/curi_model_torque_controlled.xml"
else
  echo "Using position controlled arms."
  run_simulation "../models/curi_model.xml"
fi

exit 0
