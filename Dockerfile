# OSベース: osrf/ros:humble-desktop
FROM osrf/ros:humble-desktop
SHELL ["/bin/bash", "-c"]

# 非対面モードでのインストール設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    ros-humble-cartographer \
    ros-humble-cartographer-ros \
    ros-humble-gazebo-* \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-dynamixel-sdk \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-gripper-controllers \
    ros-humble-realsense2-description \
    ros-humble-tf-transformations \
    ros-humble-moveit \
    ros-humble-moveit-servo \
    ros-humble-rosbridge-suite \
    vim \
    net-tools \
    xdg-utils \
    x11-apps \
    git \
    python3-pip \
    terminator \
    && rm -rf /var/lib/apt/lists/*

# Node.js のインストール (指定の手順)
RUN apt-get update && apt-get install -y nodejs npm && \
    npm install n -g && \
    n stable && \
    apt purge -y nodejs npm && \
    apt autoremove -y && \
    hash -r

# ワークスペースの作成
ENV WORKSPACE=/root/turtlebot3_ws
RUN mkdir -p ${WORKSPACE}/src

# リポジトリのクローン
WORKDIR ${WORKSPACE}/src
RUN git clone https://github.com/ROBOTIS-JAPAN-GIT/turtlebot3_lime -b humble-devel && \
    git clone https://github.com/ldrobotSensorTeam/ldlidar_stl_ros2.git

WORKDIR ${WORKSPACE}
RUN source /opt/ros/${ROS_DISTRO}/setup.bash && colcon build --symlink-install

WORKDIR /root
RUN git clone https://github.com/yulat214/OneStageROS.git

WORKDIR /root/OneStageROS
RUN npm install

# .bashrc への追記
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "source ~/turtlebot3_ws/install/setup.bash" >> ~/.bashrc && \
    echo "export GAZEBO_MODEL_DATABASE_URI=\"\"" >> ~/.bashrc

WORKDIR /root
