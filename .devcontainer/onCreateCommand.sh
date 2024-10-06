#!/bin/bash
PS1='\[\e[1;31m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
alias ls='ls --color=auto'
alias west='echo -e "\e[1;33m$(which west)\e[0m" && $(which west)'
source ~/.bashrc
west init -l golioth_iot
west update
west zephyr-export
pip install -r deps/zephyr/scripts/requirements.txt
west completion bash > $HOME/west-completion.bash
echo 'source $HOME/west-completion.bash' >> $HOME/.bashrc
