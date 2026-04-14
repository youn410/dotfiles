# dotfiles

## Setup

### Clone dotfiles repository

```sh
git clone https://github.com/youn410/dotfiles.git
```

### Checkout local branch tracking main branch

You can develop dotfiles in main branch and setup dotfiles in local branch.

```sh
git branch --track local
git worktree add ~/.dotfiles local
```

### Setup dotfiles

```sh
pushd ~/.dotfiles
./setup.sh
```

#### Options

| Option | Description |
|---|---|
| `-f`, `--force` | 既存の実ファイルも強制的に上書きしてシンリンクを作成する |
| `-v`, `--verbose` | シンリンクのパスを詳細表示する |
| `uninstall` | 作成済みのシンリンクをすべて削除する |

```sh
# 既存ファイルを強制上書き
./setup.sh --force

# シンリンクを削除
./setup.sh uninstall
```

### Bootstrap Nix home-manager

```sh
nix run nixpkgs#home-manager -- switch --flake . --impure
```

## Machine-local zsh configuration

`~/.zshrc` is managed by Nix (home-manager) and is read-only.
For settings that should not be committed — machine-specific `PATH`, secrets, work aliases, proxy settings, etc. — create `~/.zshrc.local`:

```sh
touch ~/.zshrc.local
```

It is sourced automatically at the end of `~/.zshrc`:

```zsh
# ~/.zshrc.local (not tracked by git)
export SOME_SECRET=...
export PATH="$HOME/work/bin:$PATH"
alias work='cd ~/work'
```

`~/.zshrc.local` is intentionally excluded from this repository.

## Machine-local git configuration

`~/.config/git/config` is managed by Nix (home-manager) and is read-only.
For settings that should not be commited -- user name, email, signing keys, etc, -- create `~/.config/git/user`;

```sh
mkdir -p ~/.config/git
touch ~/.config/git/user
```

It is included automatically via `[include] path = ~/.config/git/user` in the managed config:

```ini
# ~/.config/git/user (not tracked by git)
[user]
  name = Your name
  email = you@example.com
```

`~/.config/git/user` is intentionally excluded from this repository.
