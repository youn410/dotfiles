# nix/modules/

## 現在の構成について

各ファイルはツールごとにパッケージや設定をまとめたもの。
厳密には midchildan/dotfiles でいう **profiles/** に近い粒度。

## modules/ と profiles/ の違い

**modules/** = スイッチ付きの設定を定義する場所

```nix
options.myGit.enable = lib.mkEnableOption "git";

config = lib.mkIf config.myGit.enable {
  home.packages = [ pkgs.git ];
};
```

**profiles/** = どのマシン・用途でそのスイッチをONにするか決める場所

```nix
imports = [ ../modules/git.nix ];
myGit.enable = true;
```

## 今後の方針

マシンが増えて「このマシンには neovim 不要」などの使い分けが出てきたタイミングで、
modules（スイッチ定義）と profiles（スイッチを束ねる）に分離することを検討する。