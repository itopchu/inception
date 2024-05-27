# Inception Project

Welcome to the Inception Project! This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine. All the steps are automated with provided scripts.

## Project Overview

This project involves setting up a small infrastructure using Docker, including an NGINX server, WordPress, and MariaDB. The setup is fully automated with scripts provided in this repository. 

## Prerequisites

Before starting, ensure you have a virtual machine setup. Below are the steps for setting up a Debian 11.9 virtual machine in VirtualBox.

### Virtual Machine Setup

1. **Download Debian Image:** Use the `debian-11.9.0-amd64-netinst` image.
2. **System Configuration:**
   - Disk Size: 8GB
   - RAM: 2GB
   - CPU: 1 core
   - Enable EFI: Enable EFI (special OSes only)
3. **Display Settings:**
   - Memory: 64MB
   - VMSVGA and 3D Acceleration: Enabled
4. **Network Configuration:**
   - Port Forwarding:
     - HTTP: 80 -> 80
     - HTTPS: 443 -> 443
     - SSH: 2222 -> 2222
5. **Non-Graphical Installation:**
   - Language and Region Selection: Choose your preference.
   - Keyboard Configuration: Choose your preference.
   - Hostname: Default is fine.
   - User Configuration: Use your 42 login as the username.
   - Partitioning:
     - Guided - use entire disk
     - All files in one partition
     - Finish partitioning and write changes to disk.
   - Software Selection: Unselect everything except 'SSH server and essential'.
   - GRUB Installation: Install GRUB to the primary drive (/dev/sda) and continue.

### Usage Instructions

1. **Install Git**
   - apt-get install git

2. **Repository Structure**
These scripts automate the environment setup before running docker-compose.
   - 00_main.sh
   - 01_setup_packages.sh
   - 02_setup_ssh_config.sh
   - 03_allow_ports.sh
   - 04_add_user_to_groups.sh
   - 05_add_domain_for_user.sh
   - 06_create_inception_files.sh

Folder `Inception` contains all the necessary files for the project.

3. **Clone the Repository**

Clone this repository into `/home/$USER`

Navigate to the scripts folder and run the script `00_main.sh`:
   - cd /home/$USER/inception_project/scripts
   - ./00_main.sh


## Connecting to the VM with SSH

After the VM setup, connect to the OS terminal:
`ssh root@localhost -p 2222`

## Update Information

To have a proper project please do not forget to update:
   - ~/Inception/Makefile
   - ~/Inception/srcs/requirements/.env

## Conclusion
By following these instructions, you will set up a robust system administration project using Docker. This project not only helps you understand containerization but also equips you with practical skills for setting up and managing virtual environments.

Feel free to reach out for any clarifications or further assistance. Happy coding!