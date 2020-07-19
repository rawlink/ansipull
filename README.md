# Ansipull
There is very little good information out there on how to set up ansible-pull. I put this together as a better practice than what I have seen in other online examples. You will need to have a basic understanding of how to use Ansible before you start. Ansible's [Getting Started](http://docs.ansible.com/intro_getting_started.html) and [Best Practices](http://docs.ansible.com/playbooks_best_practices.html) documentation are great places to start.

Ansipull was designed to store your ansible-pull repo in a private git repository with key based authentication and all sensitive information stored using ansible vault with a single password. This allows you to host your ansible-pull repo with a third-party provider (e.g. a private BitBucket repo). For the truly paranoid, the repo can be privately hosted. Alternatively, if your repo is behind layers of firewall you can remove the key based authentication with a few minor modifications.

Ansipull is meant as a nice starting point. You can make Ansipull even more scalable by using Ansible's [Dynamic Inventory](http://docs.ansible.com/intro_dynamic_inventory.html). How you decide to implement that is left as an exercise for the reader :-)

## Features
* **Designed for private third-party repos.** You provide a vault password during the bootstrap process and the pull process will use that password. Your sensitive data is protected at all times.
* **The pull process is bootstrapped and maintained from a single role.** Updates to the pull process update the pull process on your managed systems.
* **Easy to repair.** If for any reason the pull process breaks on a system, the bootstrap process can be run for that server to address any pull process issues.

## Configuration
1. Add your hosts and groups to the hosts file. All hosts that you would like to manage using ansible-pull must be present in the ansible_pull group.
2. Add role assignments to your hosts in the local.yml file.
3. Add roles for managing your hosts.
4. Update configuration in roles/ansible_pull/vars/main.yml
5. Add your public key to the roles/ansible_pull/files directory and update roles/ansible_pull/tasks/main.yml for your environment.
6. Add your private key to roles/ansible_pull/vars/vault.yml using the 'ansible-vault edit' command - the password is 'password'. Create an appropriately named copy of roles/ansible_pull/templates/somesshkey.j2 and update the roles/ansible_pull/tasks/main.yml for your environment.
7. Update the vault password in roles/ansible_pull/vars/vault.yml and use that same password to encrypt roles/ansible_pull/vars/vault.yml using the 'ansible-vault rekey' command.
8. Run ssh-copy-id for each of your hosts from the machine you will use to bootstrap ansible-pull (e.g. ssh-copy-id user@host). Note that the user you copy your ssh id to must have sudo privileges.
9. Run the ansible_pull.sh file. This will bootstrap the ansible-pull process for all hosts present in the ansible_pull group in the hosts file. These hosts will then automatically run ansible-pull at the configured interval ( roles/ansible_pull/vars/main.yml ).
10. Monitor log files on your hosts to ensure everything is working.

## Troubleshooting
* If you receive errors that the host is not in inventory, please ensure that the target host's hostname is properly configured in that host's /etc/hosts file.

## TODO
* Improve documentation
