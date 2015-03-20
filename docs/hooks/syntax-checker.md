# Description

Checks for syntax errors in files that have a checker, based on the file extension.
For the moment, there is :

- a php checker, located at `hooks/syntaxchecker/php.sh`;
- an xliff checker, located at `hooks/syntaxchecker/xlf.sh`.

This hook is language-agnostic.

# Activation

```sh
git config --add hooks.enabled-plugins syntaxchecker
```
