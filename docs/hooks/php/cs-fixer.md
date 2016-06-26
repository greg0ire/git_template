# Description

Runs [php-cs-fixer][1] when detecting changed php files.

# Configuration

You can specify the path to your binary

```sh
git config hooks.php-cs-fixer.executable /custom/path/to/php-cs-fixer
```

Defaults to `php-cs-fixer`, occurs on `pre-checkout`.

# Activation

```sh
git config --add hooks.enabled-plugins php/cs-fixer
```
[1]: http://cs.sensiolabs.org/
