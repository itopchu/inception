#!/bin/bash

# Check if /etc/os-release file exists
if [ -e /etc/os-release ]; then
    # Source the os-release file to get the distribution ID
    source /etc/os-release

    # Check if the distribution ID is "debian"
    if [ "$ID" == "debian" ]; then
        # Get the Debian version using lsb_release
        debian_version=$(lsb_release -rs)

        # Check if the version is greater than or equal to 11
        if [[ "$debian_version" == "11" || "$debian_version" > "11" ]]; then
            echo "Debian version is 11 or higher. Continuing with the script."
        else
            echo "Debian version is less than 11. Exiting."
            exit 1
        fi
    else
        echo "This script is intended for Debian systems only. Exiting."
        exit 1
    fi
else
    echo "Unable to determine the operating system. Exiting."
    exit 1
fi

# Permissions to execute the scripts
chmod +x \
	01_setup_packages.sh \
	02_setup_ssh_config.sh \
    03_allow_ports.sh \
	04_add_user_to_groups.sh \
	05_add_domain_for_user.sh \
	06_create_inception_files.sh

# Run setup functions in order
source 01_setup_packages.sh
if [ $? -ne 0 ]; then
    echo "Error in 01_setup_packages.sh. Exiting."
    exit 1
fi

source 02_setup_ssh_config.sh
if [ $? -ne 0 ]; then
    echo "Error in 02_setup_ssh_config.sh. Exiting."
    exit 1
fi

source 03_allow_ports.sh
if [ $? -ne 0 ]; then
    echo "Error in 03_allow_ports.sh. Exiting."
    exit 1
fi

source 04_add_user_to_groups.sh
if [ $? -ne 0 ]; then
    echo "Error in 04_add_user_to_groups.sh. Exiting."
    exit 1
fi

source 05_add_domain_for_user.sh
if [ $? -ne 0 ]; then
    echo "Error in 05_add_domain_for_user.sh. Exiting."
    exit 1
fi

source 06_create_inception_files.sh
if [ $? -ne 0 ]; then
    echo "Error in 06_create_inception_files.sh. Exiting."
    exit 1
fi

cp -r ../Inception /home/$target_username/