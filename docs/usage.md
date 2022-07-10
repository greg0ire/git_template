# Usage

## For dummies

Just run the configuration script. From your repository root, run

    "$(git rev-parse --git-common-dir)/configure.sh"

The script will help you configure some scripts that shouldn't be configured globally.

## Manual configuration

By default, no hook will run. You must configure the hooks you need:

```sh
git config hooks.enabled-plugins php/composer
git config --add hooks.enabled-plugins php/ctags
git config --add hooks.enabled-plugins junkchecker
```

The `--add` flag is necessary if you don't want to wipe out previously added
plugins.

If you want to enable a plugin on every project, use the `--global` option:

```sh
git config --global --add hooks.enabled-plugins some_plugin
```
