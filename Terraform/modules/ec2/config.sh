#!/bin/bash
# ===========================SettingUp Envirnment for Application============================================

# Updating the bash
cd /home/ubuntu 
sudo apt update -y
sudo dpkg --configure -a
sudo apt upgrade -y
sudo apt install socat 
sudo socat TCP-LISTEN:3306,fork TCP:${DATABASE_HOST}:3306 &