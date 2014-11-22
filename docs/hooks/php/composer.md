# Description

This set of scripts monitors `composer.lock` changes and updates (or reminds you
to update) your vendor dependencies on `post-checkout` and `post-merge`.
Additionally, it checks composer.json for validity on `pre-commit`.
It assumes Composer is [globally installed][1].

# Configuration

You must tell it whether you wish it to run Composer, or if you would rather
it to notify you when you need to do it:

```sh
# If you want Composer to run each time composer.lock changes
git config hooks.composer.onChange run

# If you prefer to get a notification
git config hooks.composer.onChange just_warn
```

If the latter case, you must configure a notifier. Available notifiers for the
moment are `echo` and `notify-send`. So to use `notify-send`, which is pretty
cool, you need to do this (here, globally) :

```sh
git config --global hooks.notification.notifier notify-send
```

# Activation

```sh
git config --add hooks.enabled-plugins php/composer
```

[1]: https://github.com/composer/composer#global-installation-of-composer-manual
