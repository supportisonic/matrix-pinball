# matrix-pinball
Matrix Pinball MPF Game Code

Fast MPF Starter Configs:
https://fastpinball.com/mpf/fast-mpf-starter-configs/
Located in misc/fast-mpf-start-configs/


# Virtual Environment Install and Run:

Installing Python 3.11 on Clean Lubuntu:

- sudo add-apt-repository ppa:deadsnakes/ppa
- sudo apt-get update
- sudo apt install python3.11
- sudo apt install python3.11-venv
- mkdir ~/.mpfenv
- python3.11 -m venv ~/.mpfenv/matrix

To start environment for Python:
- source ~/.mpfenv/matrix/bin/activate

Install MPF Latest:
- pip install mpf --pre

Update to latest:
- pip install --upgrade mpf

# Allowing CoolTerm to Communicate with Linux

By default CoolTerm and MPF have issues sending and receiving serial port commands out of the box. The user needs to be added to 2 user groups in order to gain access to the commands and receive responses:

- sudo usermod -a -G dialout <user>
- sudo usermod -a -G tty <user>

Replace <user> with the actual username in those commands. Reboot is required.