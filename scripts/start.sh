#!/bin/bash
set -e

# Check if a model name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <model_name>"
    echo "Example: $0 vehicle"
    exit 1
fi

MODEL_NAME="$1"

mkdir -p /opt/ros/$ROS_DISTRO/share/std_msgs/meshes/
cp /workspace/models/${MODEL_NAME}/vehicle.* /opt/ros/$ROS_DISTRO/share/std_msgs/meshes/

source /opt/ros/$ROS_DISTRO/setup.bash
rosrun xacro xacro --inorder -o /tmp/vehicle.urdf /workspace/models/${MODEL_NAME}/vehicle.urdf.xacro
rosparam set /robot_description -t /tmp/vehicle.urdf

rosrun tf static_transform_publisher 0.0 0.0 0.0 0.0 0.0 0.0 uav/enu /base_footprint 40&
rosrun robot_state_publisher robot_state_publisher robot_state_publisher&

rviz -d /workspace/config/rviz.rviz
