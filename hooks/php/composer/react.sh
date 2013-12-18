. .git/hooks/git_config_wrapper.sh
function react()
{
	local method
	if get_hook_config composer onChange method required
	then
		case $method in
			just_warn)
				echo "You should run Composer!"
				;;
			run)
				composer install --dev
				;;
			*)
				echo "composer.onChange value should be just_warn or run" >&2
				;;
		esac
	fi
}
