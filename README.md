### 操作

```sh
# 初期設定
$ git clone git@github.com:tkmtmkt/dotconfig.git ~/.config
$ cd ~/.config/home-manager
$ bin/setup.sh

# 再設定
$ rm -rf ~/.local/state/nix
$ bin/setup.sh

# Nixパッケージ更新
$ bin/nix-flake-update.sh

# home-manager設定反映
$ bin/home-manager-switch.sh

# home-managerパッケージ一覧
$ home-manager packages

# home-manager設定編集
$ home-manager edit
```

### Nix管理

```sh
# Nixインストール
sudo mkdir -p -m 0755 /nix
sudo chown ${USER}:${USER} /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Nixを更新する
# ※これは使えない。以下のエラーで失敗する。成功した場合はバージョンが古いものになる。
# error: directory "xxxx profile" is managed by 'nix profile' and currently cannot be upgraded by 'nix upgrade-nix'
# 代替：~/.local/state/nix を削除して再インストール
$ nix upgrade-nix

# パッケージ一覧
$ nix profile list

# パッケージ名を検索する
$ nix search nixpkgs#パッケージ名 ^

# パッケージを追加する
$ nix profile add nixpkgs#パッケージ名

# パッケージを更新する
$ nix profile upgrade パッケージ名

# パッケージを削除する
$ nix profile remove パッケージ名

# Nixストアのガベージコレクション
$ nix store gc
$ nix-collect-garbage --delete-old
```

### 補足

#### リポジトリ内容
```
${HOME}
|-- .config/
|   |-- home-manager/
|   |   |-- bin/
|   |   |   |-- home-manager-switch.sh*
|   |   |   |-- nix-flake-update.sh*
|   |   |   |-- nix-store-gc.sh*
|   |   |   `-- setup.sh*
|   |   |-- dotfiles/
|   |   |-- extra/
|   |   |   `-- vimrc.vim               vim設定ファイル
|   |   |-- flake.lock
|   |   |-- flake.nix
|   |   `-- home.nix
|   |-- nix/
|   |   `-- nix.conf                    Nix設定ファイル
|   |-- .gitignore
|   `-- README.md
```

#### 実行環境のファイル構成
```
${HOME}
|-- .config/
|   `-- nix/
|       `-- nix.conf
|-- .local/
|   `-- state/
|       `-- nix/
|           `-- profiles/
|               |-- channels -> channels-1-link/
|               |-- channels-1-link -> /nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-user-environment/
|               |-- profile -> profile-1-link/
|               `-- profile-1-link -> /nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-user-environment/
|-- .nix-defexpr/
|   |-- channels -> ${HOME}/.local/state/nix/profiles/channels/
|   `-- channels_root -> /nix/var/nix/profiles/per-user/root/channels
|-- .nix-profile -> ${HOME}/.local/state/nix/profiles/profile/
|   |-- bin/
|   |-- etc/
|   |-- lib/
|   |-- libexec/
|   |-- sbin/
|   `-- share/
`-- .nix-channels
```

### 参考

- [Nix Home Manager のつまづき石をまとめる ||| Apribase](https://apribase.net/2023/08/22/nix-home-manager-qa/)
