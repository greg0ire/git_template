# Description

Runs one or several make targets on pre-commit, or on pre-push, or both.

# Activation

```sh
git config --add hooks.enabled-plugins make
```

# Configuration

By default, the `test` target will be run. To change the target:

```sh
git config hooks.make.target "my_target my_other_target"
```

By default, `make` is only run on pre-push, but pre-commit is also supported.
To change this, you can specify a list of hooks to run `make` on:

```sh
git config hooks.make.on "pre-commit pre-push"
```
