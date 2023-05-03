FROM ros:noetic-ros-base

RUN perl -p -i.bak -e 's%(deb(?:-src|)\s+)https?://(?!archive\.canonical\.com|security\.ubuntu\.com)[^\s]+%$1http://linux.yz.yamagata-u.ac.jp/pub/linux/ubuntu/archives/%' /etc/apt/sources.list

LABEL maintainer="yabashikazuya"

# shell形式を指定
SHELL ["/bin/bash", "-c"]

# 対話型プロンプトを非表示・デフォルトを自動設定(debian系linuxでのみ使用可能)
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    byobu \
    nano \
    dnsutils \
    git \
    lsb-release && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Tokyo

RUN wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc && \
    apt-key add ros.asc && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        nfs-kernel-server \
        libpng16-16 \
        python3-catkin-tools \
        python3-rosinstall-generator \
        ros-${ROS_DISTRO}-desktop-full \
        python3-pip \
        python3-rosdep \
        python3-rosinstall \
        python3-wstool \
        libbluetooth3-dev \
        libglib2.0-dev \
        build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/ros/rosdep/sources.list.d/20-default.list && \
    rosdep init && \
    rosdep update

ARG UID
ARG USER_NAME
ARG HOSTNAME
ARG DISPLAY
RUN adduser --uid ${UID} --disabled-password --gecos '' --shell /bin/bash ${USER_NAME}&& \
    chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME} && \
    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME}
WORKDIR /home/noetic/

RUN echo "export PS1='\[\033[01;32m\]${USER_NAME}@${HOSTNAME}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /home/${USER_NAME}/.bashrc && \
    echo "source /opt/ros/noetic/setup.bash" >> /home/${USER_NAME}/.bashrc && \
    echo "PYTHONIOENCODING=utf-8" >> /home/${USER_NAME}/.bashrc && \
    echo 'alias pip="pip3"' >> /home/${USER_NAME}/.bashrc

RUN mkdir catkin_ws && mkdir shared_dir


CMD ["/bin/bash"]