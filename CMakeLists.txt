cmake_minimum_required(VERSION 2.8.12)
project(clover_lab)

find_package(catkin REQUIRED)
catkin_package()

install(DIRECTORY meshes
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY srdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
