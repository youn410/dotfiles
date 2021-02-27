# dotfiles
dotfiles for my personal use.

## Installation
### Step 1: Setup your repository

### Step 2: Checkout the relevant branch

## Setup
### Install dependencies
TODO: Install brew
```

```
```
$ brew install coreutils
```

```
$ cd ~/.config/dotfiles
$ git pull
$ ./setup.sh
```

# How to update
Prepare setup branch which tracks master
```
$ git branch -vv
* local      a5fe52b [master] Merge pull request #1 from youn410/update-zsh
+ master     a5fe52b (/Users/nomu/Documents/dotfiles) [origin/master] Merge pull request #1 from youn410/update-zsh
```
When master branch is updated, apply the updated changes to local branch
```
$ git branch
* local
+ master
$ git pull master
$ ./setup.sh
```
