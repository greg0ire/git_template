# Description

Updates `.git/tags` file by scanning the project with the ctags command. It is
configured for a php project. To make vim look for this file in the `.git`
directory, you can install Tim Pope's [fugitive][1] or simply add
`set tags+=.git/tags` to your .vimrc - some plugins (like [ctrlp-tjump][2])
require this to see the tags even if fugitive is installed.

# Configuration

You can specify which kinds of tags ctags should create:

```sh
git config hooks.php-ctags.tag-kinds cdfiv
```

Default value is `cfi`. Execute `ctags --list-kinds` if you want to see which
tag kinds are available.

Optionally, you can set the projectType configuration, like this :

```sh
git config hooks.php-ctags.project-type projectType
```

Supported project types :

- symfony

This will make ctags ignore cache directories.

If you want improved PHP languages support, install the [patched version of ctags][3]
support.

Occurs on `post-checkout`, `post-commit`, and `post-merge`.

# Activation

```sh
git config --add hooks.enabled-plugins php/ctags
```
[1]: https://github.com/tpope/vim-fugitive
[2]: https://github.com/ivalkeen/vim-ctrlp-tjump
[3]: https://github.com/shawncplus/phpcomplete.vim/wiki/Patched-ctags
