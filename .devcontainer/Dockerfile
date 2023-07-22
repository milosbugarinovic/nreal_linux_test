FROM docker.io/fizmath/gpu-opencv:latest
RUN apt-key del 7fa2af80 && sed -i '/developer\.download\.nvidia\.com\/compute\/cuda\/repos/d' /etc/apt/sources.list.d/* && sed -i '/developer\.download\.nvidia\.com\/compute\/machine-learning\/repos/d' /etc/apt/sources.list.d/*
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb && dpkg -i cuda-keyring_1.0-1_all.deb

# USER $USERNAME
ENV NREAL_DRIVER_PATH=/home/nrealAirLinuxDriver \
    HIDAPI_PATH=/home/hidapi \
    JSONC_PATH=/home/json-c


RUN apt purge --auto-remove cmake -y && pip install cmake

# Install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    libusb-1.0-0-dev \
    git \
    libssl-dev\
    libjson-c-dev \
    usbutils \
    udev \
    libudev-dev \
    libusb-1.0-0-dev \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt update \
    && apt upgrade -y \
    && apt install -y libudev-dev libusb-1.0-0-dev cmake

# Clone the repository and update submodules
RUN git clone https://github.com/libusb/hidapi.git $HIDAPI_PATH \
    && git clone https://github.com/json-c/json-c.git $JSONC_PATH \
    && git clone https://gitlab.com/TheJackiMonster/nrealAirLinuxDriver.git $NREAL_DRIVER_PATH \
    && cd $NREAL_DRIVER_PATH \
    && git submodule update --init

## Build hidapi
RUN cd $HIDAPI_PATH \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && cmake --build . \
    && cmake --build . --target install

## Build json-c
RUN cd $JSONC_PATH \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && cmake --build . \
    && cmake --build . --target install

## Build json-c
RUN cd $JSONC_PATH \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && make \
    && make USE_VALGRIND=0 test \
    && make install

## Build the project
RUN cd $NREAL_DRIVER_PATH \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && make
