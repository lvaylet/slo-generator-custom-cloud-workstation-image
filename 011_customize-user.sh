#!/bin/bash

# This script runs after `010_add-user.sh` and before `020_start-sshd.sh` (so in lexicographical order).
# Reference: https://cloud.google.com/workstations/docs/customize-container-images#cloud-workstations-base-image-structure

# Run config script as `user`.
su -c "/tmp/script.sh" user
