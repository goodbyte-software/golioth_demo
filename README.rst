Golioth demo repository - Goodbyte Software
#######################

This README helps to install GoliothSDK properly with our demo.

Boards
======

Demo is currently working with nRF7002-DK.

Docker set up
************

Our Docker image is a base that contains all system dependencies needed to work with Zephyr.


Use Docker to initialize workspace
======================================

.. code-block:: console

    docker compose up
    OR
    use devcontainers in VSC

Build & flash
==============

.. code-block:: console

   west init -l golioth_iot && west update # only first time
   west build --board nrf7002dk_nrf5340_cpuapp golioth_iot --pristine
   west flash


Explanation
===========
We are using west manifest files to download project specific dependencies.
Files downloaded by manifest are also shared to local host in /repo directory.

References
==========
`<https://github.com/golioth/zephyr-training>`_

`<https://www.nordicsemi.com/Products/Development-hardware/nRF7002-DK>`_





