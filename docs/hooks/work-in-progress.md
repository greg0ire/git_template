# Work In Progress checker hook

Checks for commit messages starting with "WIP" and prevents you from pushing
the corresponding commits. Occurs on `pre-push` (obviously).

This can be ignored with an option :

```sh
git push --no-verify
```

This hook is language-agnostic.

Enable it :

```sh
git config --add hooks.enabled-plugins wipchecker
```
