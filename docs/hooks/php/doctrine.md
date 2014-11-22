# Description

These hooks run the `doctrine:schema:validate` task of a Symfony project and
update / migrate your database depending on the presence of a
`doctrine-migrations` folder in your vendor directory on `post-checkout` and
`post-commit`.

# Activation

```sh
git config --add hooks.enabled-plugins php/doctrine
```
