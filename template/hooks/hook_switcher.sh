#!/bin/bash
hook_is_enabled() {
	local hook=$1
	if [ "$(git config --get-all hooks.enabled-plugins|grep "$hook")" == "$hook" ]
	then
		return 0
	else
		return 1
	fi

}

switch_hook() {
	local hook=$1
	if hook_is_enabled "$hook"
	then
		if [ "$(git config --get-all --global hooks.enabled-plugins|grep "$hook")" == "$hook" ]
		then
			echo "$hook is globally enabled"
		else
			read -p "$hook is enabled. Keep it ? (y/n)" -n 1
			if [[ ! $REPLY =~ ^[Yy]$ ]]
			then
				git config --unset hooks.enabled-plugins "$hook"
			fi
		fi
	else
		read -p "$hook is disabled. Enable it ? (y/n)" -n 1
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			git config --add hooks.enabled-plugins "$hook"
		fi
	fi
	echo "" # line break
}
