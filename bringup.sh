#!/bin/bash

# Cyber-Dojo
# https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on.html
# https://blog.cyber-dojo.org/2017/09/running-your-own-cyber-dojo-server.html
# Digital Ocean
# https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/to-account/
# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

confirm "Get Docker? [y/N]" && wget -qO- https://get.docker.com/ | sh
confirm "Add dojo user? [y/N]" && adduser dojo
confirm "Add dojo to sudoers? [y/N]" && usermod -aG sudo dojo
confirm "Add dojo to docker? [y/N]" && usermod -aG docker dojo
confirm "Add dojo to ssh? [y/N]" && rsync --archive --chown=dojo:dojo ~/.ssh /home/dojo
confirm "Make /cyber-dojo directory? [y/N]" && sudo mkdir /cyber-dojo
confirm "Chown /cyber-dojo? [y/N]" && sudo chown 19663:65533 /cyber-dojo
confirm "Curl cyber-dojo? [y/N]" && curl -O https://raw.githubusercontent.com/cyber-dojo/commander/master/cyber-dojo
confirm "Chmod cyber-dojo? [y/N]" && chmod 700 cyber-dojo
