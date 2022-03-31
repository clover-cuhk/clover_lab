# Clover Lab

This is the ROS package hosting the description of CLOVER Lab CUHK.

# Introduction

The CLOVER lab's experiment zone is a simulated kitchen area equipped with a base cabinet and a wall cabinet from IKEA.
This scenario enables testing robots to assist human in household works.

This package provides the models of the kitchen furniture we use and the environment layout. An accurate model is needed
for planning pipelines such as [Humanoid Path Planner](<https://humanoid-path-planner.github.io/hpp-doc/>), hence here
we precisely model the items based on IKEA's data and measured sizes.

# Usage

The URDF files in the [urdf](urdf) folder are derived from the xacro files using the script `build.sh`
in [scripts](scripts), wherein through running this script, the URDF files for the whole scene and the furniture will be
automatically built.

