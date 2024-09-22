ARG NRF_CLTOOLS_VERSION=10.24.2
ARG NRF_SDK_VERSION=2.7.0
ARG NRF_TOOLCHAIN_VERSION=2.6.1

ARG CLANGD_VERSION=18.1.3
ARG JLINK_DEB=JLink_Linux_V796d_x86_64.deb
ARG OZONE_DEB=Ozone_Linux_V326i_x86_64.deb
ARG SOURCETRAIL_VERSION=2021.4.19
ARG SYSTEMVIEW_DEB=SystemView_Linux_V352_x86_64.deb

FROM ubuntu:22.04 as base_downloader
RUN apt-get -y update && apt-get install -y wget

RUN apt-get -y update && apt-get install -y \
    wget \
    unzip 


# Download JLINK
FROM base_downloader AS jlink_downloader
ARG JLINK_DEB
RUN wget --post-data "accept_license_agreement=accepted" https://www.segger.com/downloads/jlink/$JLINK_DEB -O jlink.deb

# Download Ozone
FROM base_downloader AS ozone_downloader
ARG OZONE_DEB
RUN wget --post-data "accept_license_agreement=accepted" https://www.segger.com/downloads/jlink/$OZONE_DEB -O ozone.deb

# Download Clangd
FROM base_downloader AS clangd_downloader
ARG CLANGD_VERSION
RUN wget https://github.com/clangd/clangd/releases/download/$CLANGD_VERSION/clangd-linux-$CLANGD_VERSION.zip -O clangd.zip && \
    unzip clangd.zip -d clangd

# Download Sourcetrail
# Sourcetrail - https://github.com/CoatiSoftware/Sourcetrail/releases
FROM base_downloader AS sourcetrail_downloader
ARG SOURCETRAIL_VERSION
SHELL [ "/bin/bash", "-c" ]
RUN wget "https://github.com/CoatiSoftware/Sourcetrail/releases/download/${SOURCETRAIL_VERSION}/Sourcetrail_${SOURCETRAIL_VERSION//./_}_Linux_64bit.tar.gz" && \
    tar -xzf Sourcetrail_${SOURCETRAIL_VERSION//./_}_Linux_64bit.tar.gz

# Download Systemview
FROM base_downloader AS systemview_downloader
ARG SYSTEMVIEW_DEB
RUN wget --post-data "accept_license_agreement=accepted" https://www.segger.com/downloads/jlink/$SYSTEMVIEW_DEB -O systemview.deb

FROM base_downloader AS nrfcli_downloader
ARG NRF_CLTOOLS_VERSION
SHELL [ "/bin/bash", "-c" ]
RUN wget "https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-command-line-tools/sw/versions-10-x-x/${NRF_CLTOOLS_VERSION//./-}/nrf-command-line-tools_${NRF_CLTOOLS_VERSION}_amd64.deb" \
    -O nrf_cli_tool.deb

FROM ubuntu:22.04 as base

ENV DEBIAN_FRONTEND noninteractive
ENV TZ ="Europe/Warsaw"
# Base toolchain
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y \
    apt-utils \
    vim \
    sudo \
    unzip \
    wget \
    curl \
    autoconf \
    file \
    udev \
    dfu-util \
    doublecmd-gtk \
    mc \
    gitg \
    tzdata \
    binutils \
    gperf \
    ninja-build \
    device-tree-compiler \
    xz-utils \
    libsdl2-dev \
    cmake

# Dev toolchain
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    gdb \
    make \
    gcc-multilib \
    g++-multilib \
    libgtest-dev \
    libgmock-dev \
    ccache \
    cppcheck \
    clang-tidy \
    clang-format \
    libffi7 \
    terminator \
    minicom

WORKDIR /tmp

# Install JLink
RUN apt-get update && apt-get -y install \
    libftdi1-dev \
    libncursesw5 \
    libusb-dev \
    libxcursor-dev \
    libxfixes-dev \
    libxrandr2
COPY --from=jlink_downloader jlink.deb jlink.deb
RUN /lib/systemd/systemd-udevd --daemon && udevadm control --reload-rules && \
    apt-get install -y ./jlink.deb && rm jlink.deb

# Install Ozone
COPY --from=ozone_downloader ozone.deb ozone.deb
RUN apt-get install -y ./ozone.deb && rm ozone.deb

# Install Clangd
ARG CLANGD_VERSION
COPY --from=clangd_downloader clangd/clangd_$CLANGD_VERSION/bin/clangd /usr/bin
COPY --from=clangd_downloader clangd/clangd_$CLANGD_VERSION/lib/clang /usr/lib

# Install Sourcetrail
COPY --from=sourcetrail_downloader Sourcetrail Sourcetrail
RUN ./Sourcetrail/install.sh && rm -rf Sourcetrail

# Install Systemview
COPY --from=systemview_downloader systemview.deb systemview.deb
RUN apt-get install -y ./systemview.deb && rm systemview.deb


# Download nRF Command Line Tools


# Installing the nRF Connect SDK using recommended steps
# https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/installation/install_ncs.html#

ARG NRF_SDK_VERSION
ARG NRF_TOOLCHAIN_VERSION
ARG USER_NAME=dev
ARG USER_PASSWORD=1234
ARG USER_ID=1000
ARG GROUP_ID=1000
USER root

# bash is required to support source and string substitution like ${var//pattern/string}
SHELL [ "/bin/bash", "-c" ]

# create user and add it to sudoers
RUN addgroup --gid $GROUP_ID $USER_NAME && \
    adduser --disabled-password --gecos '' --shell /bin/bash --uid $USER_ID --gid $GROUP_ID $USER_NAME && \
    set -o pipefail && \
    echo "$USER_NAME:$USER_PASSWORD" | chpasswd && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Installing the nRF Connect SDK using recommended steps
# https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/nrf/installation/install_ncs.html#

# nRF Command Line Tools - https://infocenter.nordicsemi.com/index.jsp?topic=%2Fug_nrf_cltools%2FUG%2Fcltools%2Fnrf_installation.html
COPY --from=nrfcli_downloader nrf_cli_tool.deb nrf_cli_tool.deb
RUN apt-get install -y ./nrf_cli_tool.deb && rm ./nrf_cli_tool.deb

# nRF Util - https://infocenter.nordicsemi.com/index.jsp?topic=%2Fug_nrf_cltools%2FUG%2Fcltools%2Fnrf_installation.html
RUN wget https://developer.nordicsemi.com/.pc-tools/nrfutil/x64-linux/nrfutil && \
    chmod +x nrfutil && \
    mv nrfutil /usr/local/bin

RUN apt-get -y update && apt-get install -y \
    python3 \
    python3-setuptools \
    python3-pip \
    python3-dev \
    python3-pyelftools \
    python3-wheel && pip3 install west

# Install Zephyr SDK
WORKDIR /opt
ENV ZEPHYR_SDK_INSTALL_DIR /opt/zephyr-sdk-0.16.8
RUN wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.8/zephyr-sdk-0.16.8_linux-x86_64.tar.xz \
    && tar xvf zephyr-sdk-0.16.8_linux-x86_64.tar.xz \
    && ${ZEPHYR_SDK_INSTALL_DIR}/setup.sh -h -t arm-zephyr-eabi \
    && ${ZEPHYR_SDK_INSTALL_DIR}/setup.sh -t x86_64-zephyr-elf \
    && rm zephyr-sdk-0.16.8_linux-x86_64.tar.xz

# Perform all futher steps as USER
USER ${USER_NAME}
ENV PATH=$PATH:/home/dev/.local/bin

# CodeChecker
RUN pip install CodeChecker

# bash history placeholder
ENV HISTFILE /home/${USER_NAME}/.history/.bash_history
RUN mkdir $(dirname ${HISTFILE}})

# ~/.bashrc
RUN echo ""  >> ~/.bashrc && \
    echo "parse_git_branch() {"  >> ~/.bashrc && \
    echo "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/^[ *\t]*//' -e 's/^/ (/' -e 's/$/)/'| head" >> ~/.bashrc && \
    echo "}" >> ~/.bashrc && \
    echo 'export PS1="\u@\h \[\033[36m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] # "' >> ~/.bashrc

WORKDIR /repo
ENTRYPOINT /bin/bash
