#!/bin/bash

# https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on.html
# https://blog.cyber-dojo.org/2017/09/running-your-own-cyber-dojo-server.html

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

confirm "Get Docker?" && wget -qO- https://get.docker.com/ | sh
confirm "Add dojo user?" && adduser dojo
confirm "Add dojo to sudoers?" && usermod -aG sudo dojo
confirm "Add dojo to docker?" && usermod -aG docker dojo
confirm "Make /cyber-dojo directory?" && sudo mkdir /cyber-dojo
confirm "Chown /cyber-dojo?" && sudo chown 19663:65533 /cyber-dojo
confirm "Curl cyber-dojo?" && curl -O https://raw.githubusercontent.com/cyber-dojo/commander/master/cyber-dojo
confirm "Chmod cyber-dojo?" && chmod 700 cyber-dojo
