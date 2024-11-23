#!/bin/bash

set -e

is_root="$(whoami)"
if [[ $is_root =~ "root" ]]; then
    SUDO=""
else
    SUDO="sudo"
fi

if [[ $1 == "--yes" ]]; then
    FORCE_APT_INSTALL="-y"
fi


$SUDO apt-get update
$SUDO apt-get install $FORCE_APT_INSTALL ros-$ROS_DISTRO-rviz \
                                         ros-$ROS_DISTRO-xacro \
                                         ros-$ROS_DISTRO-robot-state-publisher
