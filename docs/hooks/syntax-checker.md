# Description

Checks for syntax errors in files that have a checker, based on the file extension.
For the moment, there only is a php checker, located at `hooks/syntaxchecker/php/check.sh`.

This hook is language-agnostic.

# Activation

```sh
git config --add hooks.enabled-plugins syntaxchecker
```
