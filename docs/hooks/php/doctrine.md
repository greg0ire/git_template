# Description

These hooks run the `doctrine:schema:validate` task of a Symfony project and
update / migrate your database depending on the presence of a
`doctrine-migrations` folder in your vendor directory on `post-checkout` and
`post-commit`.

# Configuration

You can change the symfony executable (default value `app/console`). Useful if
you are using docker and you want to execute the binary in the container, for
instance.

```sh
git config hooks.doctrine.sf-executable "docker exec my_container /path/to/app/console"
```

# Activation

```sh
git config --add hooks.enabled-plugins php/doctrine
```
