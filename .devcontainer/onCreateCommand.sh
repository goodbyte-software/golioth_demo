#!/bin/bash
west init -l golioth_iot
west update
west zephyr-export
pip install -r deps/zephyr/scripts/requirements.txt
west completion bash > $HOME/west-completion.bash
nrfutil install nrf5sdk-tools
nrfutil install device
echo 'source $HOME/west-completion.bash' >> $HOME/.bashrc
echo "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/^[ *\t]*//' -e 's/^/ (/' -e 's/$/)/'| head" >> ~/.bashrc && \
echo "}" >> ~/.bashrc && \
echo 'export PS1="\u@\h \[\033[36m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] # "' >> ~/.bashrc

