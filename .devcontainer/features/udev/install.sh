#!/bin/bash

apt-get install -y udev 
wget https://github.com/NordicSemiconductor/nrf-udev/releases/download/v1.0.1/nrf-udev_1.0.1-all.deb
dpkg -i nrf-udev_1.0.1-all.deb

