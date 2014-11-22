# Description

The `post-commit` hook makes [Sismo][1] run each time you commit. It is a `post-commit`
hook because Sismo is a *local* Continuous Testing Server, which means you can
build before you push, thus making sure no failing build ever comes out of your
repo, and even making sure each commit passes the tests, because you can rewrite
failing commits.

# Configuration

You must configure the path to the sismo executable, and you may do so globally,
like this:

```sh
git config --global --add hooks.php-sismo.path /usr/share/nginx/html/sismo.php
```

You must also configure the slug of your project:

```sh
git config hooks.php-sismo.slug my-slug
```

# Activation

```sh
git config --add hooks.enabled-plugins php/sismo
```

[1]: http://sismo.sensiolabs.org/ "A local Continuous Testing Server"
