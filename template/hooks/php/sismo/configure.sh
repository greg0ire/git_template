#!/bin/bash
. .git/hooks/hook_switcher.sh

main() {
	if hook_is_enabled php/sismo
	then
		read -p "Specify the sismo slug for this project : "
		git config hooks.php-sismo.slug "$REPLY"
	fi
}

main
