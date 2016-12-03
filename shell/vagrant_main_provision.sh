#!/usr/bin/env bash

if ! ansible --version | grep ansible;
then
    echo "-> Installing Ansible"
    # Add Ansible Repository & Install Ansible


    yum clean all && \
    yum -y install epel-release && \
    yum -y install ansible
    # Install Ansible

    # Add SSH key
    #cat /ansible/files/authorized_keys >> /home/vagrant/.ssh/authorized_keys
else
        echo "-> Ansible already Installed!"
fi

# Install Ansible Galaxy modules
# To review in furure: http://docs.ansible.com/ansible/galaxy.html#id12
echo "-> Installing Ansibe Galaxy Modules"
roles_list[0]='geerlingguy.mysql'
roles_list[1]='geerlingguy.apache'

for role_and_version in "${roles_list[@]}"
do
    role_and_version_for_grep="${role_and_version/,/, }"

    if ! sudo ansible-galaxy list | grep -qw "$role_and_version_for_grep";
    then
            echo "Installing ${role_and_version}"
            sudo ansible-galaxy -f install $role_and_version
    else
        echo "Already installed ${role_and_version}"
    fi
done

echo "Copiar rol para compiar ficheros"

 sudo cp -R /ansible/rol/carlos.copyfiles/ /etc/ansible/roles/carlos.copyfiles



# Execute Ansible
echo "-> Execute Ansible"
ansible-playbook -e 'host_key_checking=False' /ansible/Practica.yaml -i /ansible/inventories/hosts 
