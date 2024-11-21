# dotfiles
## Setup
### Clone dotfiles repository
```
git clone https://github.com/youn410/dotfiles.git
```
### Checkout local branch tracking main branch
You can develop dotfiles in main branch and setup dotfiles in local branch.
```
git branch --track local
git worktree add ~/.dotfiles local
```
### Setup dotfiles
```
pushd ~/.dotfiles
./setup.sh
```

### Bootstrap Nix home-manager
```
nix run nixpkgs#home-manager -- switch --flake .#myHomeConfig
```
