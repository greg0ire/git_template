# Description

Adds a ticket reference to  the commit-msg, this allows for some workflows to
be able to correlate a number of commits against a specific
feature/ticket/incident/issue etc. once merged.

A branch of `ABC-1234-hello-world` would turn a commit of
`git commit -m "Hello World"` into `[ABC-1234] Hello World`. (by default)

# Activation

```sh
git config --add hooks.enabled-plugins ticketref
```

# Configuration

By default this hook will prefix the commit message with the ticket reference,
this can be configured to be added as a suffix via:
```sh
git config hooks.ticketref.position "POST"
```
