<p align="center">
  <img src="https://raw.githubusercontent.com/qaraluch/qyadr/master/.pic/qyadr-logo.jpg" alt="qyadr logo" width="880" />
</p>

<h1 align="center">:package: QYADR</h1>

<p align="center">
 <b>Qaraluch's Yet Another Dotfiles Repo</b>
</p>

<p align="center">
   <a href="https://opensource.org/licenses/mit-license.php">
    <img alt="MIT Licence" src="https://badges.frapsoft.com/os/mit/mit.svg?v=103" />
  </a>
</p>

<br />

- Easy in **deploy**, **installation**, **update**, and **purging**.
- Version control via **GIT**.
- Based on **ZSH** shell.
- Configurable **plugins** and first-time-auto-installation.
- Zsh **completions**.
- Goodness of command-line fuzzy finder (**fzf**) for git, zsh and locate.
- Navigate directories via **fzf-makrs**.
- Shell **autosuggestions**.
- Command line **syntax highlighting**.
- Zsh **global aliases** expansion (via zsh-abbrev-alias).
- **Vim keybindings** in terminal.
- Custom **prompt**.
- Custom **aliases**.
- Simple **profiling**.
- Powered by **GNU STOW** for components and environment installation management.
- And much more...

:warning: Disclaimer:
This repo is published in good faith and for learning purpose only. Any usage of the dotfiles is strictly at your own risk :see_no_evil:.

## :white_circle: Prerequisites

Make sure the following requirements are installed:

- Git
- GNU Stow

## :white_circle: Installation

For installation of the dotfiles you need to download deployment script beforehand:

```sh
curl -LO https://git.io/.qyadr-deploy.sh
```

or:

```sh
$ curl https://raw.githubusercontent.com/qaraluch/qyadr/master/deploy.sh -Lo .qyadr-deploy.sh
```

and run it by:

```sh
$ bash ~/.qyadr-deploy.sh
```

Run installer by:

```
$ ~/.qyadr-install.sh
```

## :white_circle: License

MIT © [qaraluch](https://github.com/qaraluch)
