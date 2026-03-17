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
nix run nixpkgs#home-manager -- switch --flake .#myHomeConfig
```
