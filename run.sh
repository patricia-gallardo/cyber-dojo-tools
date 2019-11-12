#!/bin/bash

# https://blog.cyber-dojo.org/2017/09/running-your-own-cyber-dojo-server.html
# Digital Ocean : ssh dojo@134.209.205.242

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

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

confirm "Create start point? [y/N]" && ./cyber-dojo start-point create insecure --custom https://github.com/patricia-gallardo/insecure-cplusplus-dojo
confirm "Bring up custom? [y/N]" && ./cyber-dojo up --custom=insecure
confirm "Bring up custom + web? [y/N]" && CYBER_DOJO_WEB_IMAGE=turtlesec/web CYBER_DOJO_WEB_TAG=latest ./cyber-dojo up --custom=insecure
confirm "Bring up custom + swarm? [y/N]" && CYBER_DOJO_SWARM=true ./cyber-dojo up --custom=insecure
confirm "Bring up default? [y/N]" && ./cyber-dojo up
confirm "Shut down cyber-dojo? [y/N]" && ./cyber-dojo down
confirm "Update cyber-dojo? [y/N]" && ./cyber-dojo update
