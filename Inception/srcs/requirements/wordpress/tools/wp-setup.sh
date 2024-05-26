#!/bin/bash

# Ensure WordPress is installed and configured
wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --skip-email

# Create another user
wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PWD}