#!/bin/bash

wget https://github.com/clangd/clangd/releases/download/19.1.0/clangd-linux-19.1.0.zip -O clangd.zip
unzip clangd.zip -d clangd
cp clangd/clangd_*/bin/clangd /usr/bin
cp -r clangd/clangd_*/lib/clang /usr/lib
