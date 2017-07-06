# Description

Prefixes the commit-msg with the ticket reference, this allows for some workflows to be able to correlate a number of commit's against a specific feature/ticket/incident/issue etc once merged.

a branch of `ABC-1234-hello-world` would turn a commit of `git commit -m "Hello World"` into `[ABC-1234] Hello World`

# Activation

```sh
git config --add hooks.enabled-plugins ticketref
```
