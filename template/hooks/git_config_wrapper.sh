#!/bin/bash

# Gets a required configuration key from the git config
#
# @param string the name of the hook
# @param string the name of the configuration key
# @param string the name of the variable where the return value should be stored
# @param string required | optional whether this config is required of optional
# @param string a default value for the option. Implies optional.
#
# @return int   0: success
#               1: misuse
#               2: key not set
function get_hook_config()
{
	local isRequired
	if [ $# -ne 4 -a $# -ne 5 ]
	then
		echo "Usage: $0 <hook>, <option>, <return_variable_name> required|optional [default_value]" >&2
		return 1
	fi
	case $4 in
		optional)
			isRequired=false
		;;
		required)
			isRequired=true
		;;
		*)
			echo "Invalid argument : $4" >&2
		;;
	esac

	local __resultvar=$3
	local value
	git config --get "hooks.$1.$2" > /dev/null
	if [ $? -ne 0 ]
	then
		if $isRequired
		then
			echo "$2 configuration key of the $1 plugin must be set." >&2
			echo "You may set it like this : git config hooks.$1.$2 some_value" >&2
			return 2
		else
			if [ -z ${5+x} ]
			then
				return 2
			else
				value=$5
			fi
		fi
	else
		local value="$(git config --get "hooks.$1.$2")"
	fi
	eval "$__resultvar=\"$value\""
	return 0
}
