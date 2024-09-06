Golioth repository from zephyr-training. 
#######################

https://github.com/golioth/zephyr-training   



This README helps to install GoliothSDK properly with some samples from their github. Our demo-sample is also located inside app directory. 


Boards
======
Samples are currently working with 7002DK and 9160DK.

Local set up
************

Do not clone this repo using git. Zephyr's ``west`` meta tool should be used to
set up your local workspace.

Install the Python virtual environment (recommended)
====================================================

.. code-block:: console

   cd ~
   mkdir zephyr-training
   python -m venv zephyr-training/.venv
   source zephyr-training/.venv/bin/activate
   pip install wheel west

Use ``west`` to initialize and install
======================================

.. code-block:: console

   cd ~/zephyr-training
   west init -m git@github.com:golioth/zephyr-training.git .
   west update
   west zephyr-export
   pip install -r deps/zephyr/scripts/requirements.txt






