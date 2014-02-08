switch_hook() {
	local hook=$1
	if [ "`git config --get-all hooks.enabled-plugins|grep $hook`" == "$hook" ]
	then
		read -p "$hook is enabled. Keep it ? (y/n)" -n 1
		if [[ ! $REPLY =~ ^[Yy]$ ]]
		then
			git config --unset hooks.enabled-plugins  $hook
		fi
	else
		read -p "$hook is disabled. Enable it ? (y/n)" -n 1
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			git config --add hooks.enabled-plugins $hook
		fi
	fi
	echo "" # line break
}
