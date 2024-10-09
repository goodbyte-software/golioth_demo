#!/bin/bash


NCLT_URL="https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-command-line-tools/sw/versions-10-x-x/10-24-0/nrf-command-line-tools-10.24.0_linux-amd64.tar.gz"


if [ -n "$NCLT_URL" ]; then

    TEMP_DIR=$(mktemp -d)
    cd $TEMP_DIR


    wget -qO- "$NCLT_URL" | tar -xz || { echo "Download error"; exit 1; }


    if [ -f JLink_*.tgz ]; then
        mkdir -p /opt/SEGGER
        tar -xzf JLink_*.tgz -C /opt/SEGGER
        mv /opt/SEGGER/JLink* /opt/SEGGER/JLink
    else
        echo "JLink package not found!"
    fi


    if [ -d ./nrf-command-line-tools ]; then
        cp -r ./nrf-command-line-tools /opt
        ln -sf /opt/nrf-command-line-tools/bin/nrfjprog /usr/local/bin/nrfjprog
        ln -sf /opt/nrf-command-line-tools/bin/mergehex /usr/local/bin/mergehex
    else
        echo "nrf-command-line-tools not found!"
    fi


    cd ~
    rm -rf $TEMP_DIR
else
    echo "Skipping nRF Command Line Tools installation (URL not provided)"
fi

