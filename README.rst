.. image:: .assets/logo_gb.png
   :alt: Logo GB
   :width: 600

Golioth demo repository - Goodbyte Software
#######################

This is an adapted version of this `Golioth Zephyr training example <https://github.com/golioth/zephyr-training/tree/1d8840429516d862fb71c21c833e6e283d705927/01_IOT>`_

It has been modified by Goodbyte Software for educational purposes `<Changes> <https://github.com/goodbyte-software/golioth_demo/compare/init...master?expand=1>`_. 
The original project is licensed under the Apache License 2.0, and any changes have been made in accordance with this license.

Our goal was to facilitate a quick start with Golioth, using Visual Studio Code and Dev Containers.

In fact, after cloning this repository and creating an account on Golioth, you should be able to run this Golioth project in 5 simple steps.


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

   cd golioth_iot
   west build --board nrf7002dk_nrf5340_cpuapp --pristine
   west flash


Explanation
===========
We are using west manifest files to download project specific dependencies.
Files downloaded by manifest are also shared to local host in /repo directory.

References
==========
`<https://github.com/golioth/zephyr-training>`_

`<https://www.nordicsemi.com/Products/Development-hardware/nRF7002-DK>`_


## 📜 License
This project is licensed under Apache-2.0 same as the original project.