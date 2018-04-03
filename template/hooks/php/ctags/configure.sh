#!/bin/bash -u
. "$GIT_DIR/hooks/hook_switcher.sh"

main() {
	local projectType

	if hook_is_enabled php/ctags
	then
		PS3="Select a project type : "
		select projectType in symfony1 symfony2 none;
		do
			case $projectType in
				symfony1|symfony2)
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
