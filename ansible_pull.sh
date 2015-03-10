#!/bin/sh
ansible-playbook -i hosts -s -K --ask-vault-pass -e "pull_mode_bootstrap=true" ansible_pull.yml
