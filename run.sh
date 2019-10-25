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

confirm "Create start point? [y/N]" && ./cyber-dojo start-point create insecure --custom https://github.com/patricia-gallardo/insecure-cplusplus-dojo
confirm "Bring up with start point? [y/N]" && ./cyber-dojo up --custom=insecure
confirm "Bring up default? [y/N]" && ./cyber-dojo up
confirm "Shut down? [y/N]" && ./cyber-dojo down
