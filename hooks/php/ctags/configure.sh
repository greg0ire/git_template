#!/bin/bash
. .git/hooks/hook_switcher.sh

main() {
	echo "Configuring php/ctags"
	switch_hook php/ctags
}

main
