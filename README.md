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

### Connecting to the VM and Installing Git

After the VM setup, connect to the OS terminal: