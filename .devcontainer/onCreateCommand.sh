#!/bin/bash
west init -l golioth_iot
west update
west zephyr-export

pip install -r deps/zephyr/scripts/requirements.txt

nrfutil install nrf5sdk-tools
nrfutil install device

west completion bash > $HOME/west-completion.bash
echo 'source $HOME/west-completion.bash' >> $HOME/.bashrc

echo 'parse_git_branch() {' >> $HOME/.bashrc
echo "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/^[ *\t]*//' -e 's/^/ (/' -e 's/$/)/'| head" >> $HOME/.bashrc
echo "}" >> $HOME/.bashrc
echo 'export PS1="\u@\h \[\033[36m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] # "' >> $HOME/.bashrc

echo 'export ZEPHYR_SDK_INSTALL_DIR=/opt/toolchains/zephyr-sdk-0.16.3' >> $HOME/.bashrc
echo 'source /repo/deps/zephyr/zephyr-env.sh' >> $HOME/.bashrc