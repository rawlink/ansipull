# Ansipull

There is very little good information out there on how to set up ansible pull. I put this together as a better practice than what I have seen in other online examples. You will need to have a basic understanding of how to use ansible. Ansible's [Getting Started](http://docs.ansible.com/intro_getting_started.html) and [Best Practices](http://docs.ansible.com/playbooks_best_practices.html) would be great places to start.

Ansipull was designed to store your ansible-pull repo in a private git repository with key based authentication and all sensitive information stored using ansible vault with a single password. This allows you to keep your ansible-pull repo in a private BitBucket repo for example. For the truly paranoid you can keep your repo in a totally private repo. Alternatively, if your repo is behind layers of firewall you can remove the key based authentication with a few minor modifications.

Ansipull is meant as a nice starting point. You can make Ansipull even more scalable by using Ansible's [Dynamic Inventory](http://docs.ansible.com/intro_dynamic_inventory.html).

To get started:
1. Add your hosts and groups to the hosts file. All hosts that you would like to manage using ansible-pull must be present in the ansible_pull group.
2. Add role assignments to your hosts in the local.yml file.
3. Add roles for managing your hosts.
4. Update configuration in roles/ansible_pull/vars/main.yml
5. Add your public key to the roles/ansible_pull/files directory and update roles/ansible_pull/tasks/main.yml for your environment.
6. Add your private key to roles/ansible_pull/vars/vault.yml using the 'ansible-vault edit' command - the password is 'password'. Create an appropriately named copy of roles/ansible_pull/templates/somesshkey.j2 and update roles/ansible_pull/tasks/main.yml for your environment.
7. Update the vault password in roles/ansible_pull/vars/vault.yml and use that same password to encrypt roles/ansible_pull/vars/vault.yml using the 'ansible-vault rekey' command.
8. Update the ssh config and known hosts sections of the roles/ansible_pull/tasks/main.yml file for your environment.
9. Run ssh-copy-id for each of your hosts from the machine you will use to bootstrap ansible-pull (e.g. ssh-copy-id user@host). Note that the user you copy your ssh id to must have sudo privileges.
10. Run the ansible_pull.sh file. This will bootstrap the ansible-pull process for all hosts present in the ansible_pull group in the hosts file. These hosts will then automatically run ansible-pull at the configured interval ( roles/ansible_pull/vars/main.yml ).

## Troubleshooting
* If you receive errors that the host is not in inventory, please ensure that the target hosts hostname is properly configured in that hosts /etc/hosts file.

## TODO
* Improve documentation
