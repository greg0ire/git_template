#!/bin/bash -u
. "$GIT_COMMON_DIR/hooks/hook_switcher.sh"

main() {
	local projectType

	if hook_is_enabled php/ctags
	then
		PS3="Select a project type : "
		select projectType in symfony none;
		do
			case $projectType in
				symfony)
					git config hooks.php-ctags.project-type $projectType
					break
				;;
				none)
					echo "no project type... do nothing"
					break
				;;
			esac
		done
	fi
}

main
