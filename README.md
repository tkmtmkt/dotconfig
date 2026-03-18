### 初期設定

```sh
# Nixストアディレクトリ作成
$ sudo mkdir -m 0755 /nix
$ sudo chown setup:setup /nix

# Nixインストール
$ sh <(curl -L https://nixos.org/nix/install) --no-daemon
$ . ~/.nix-profile/etc/profile.d/nix.sh
$ nix --version

# home-manager有効化
$ nix run home-manager switch --impure
```

### Nix管理

```sh
# Nixを更新する
$ nix upgrade-nix

# パッケージ一覧
$ nix profile list

# パッケージ名を検索する
$ nix search nixpkgs#パッケージ名 ^

# パッケージを追加する
$ nix profile add nixpkgs#パッケージ名

# パッケージを更新する
$ nix profile update パッケージ名

# パッケージを削除する
$ nix profile remove パッケージ名

# Nixストアのガベージコレクション
$ nix store gc
$ nix-collect-garbage --delete-old
```

### home-manager管理

```sh
# パッケージ更新
$ cd ~/.config/home-manager
$ nix flake update
$ home-manager switch

# パッケージ一覧
$ home-manager packages

# 設定編集
$ home-manager edit

# 有効化
$ home-manager switch --impure
```

### 補足

```
|-- .config/
|   |-- home-manager/
|   |   |-- dotfiles/
|   |   |-- flake.lock
|   |   |-- flake.nix
|   |   `-- home.nix
|   |-- nix/
|   |   `-- nix.conf
|   |-- .gitignore
|   `-- README.md
|-- .local/
|   |-- share/
|   |   `-- uv/
|   |       |-- python/
|   |       `-- tools/
|   `-- state/
|       `-- nix/
|           `-- profiles/
|               |-- channels -> channels-1-link/
|               |-- channels-1-link -> /nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-user-environment/
|               `-- profile -> profile-1-link/
|               `-- profile-1-link -> /nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-user-environment/
|-- .nix-defexpr/
|   |-- channels -> /home/takamatu/.local/state/nix/profiles/channels/
|   `-- channels_root -> /nix/var/nix/profiles/per-user/root/channels
|-- .nix-profile -> /home/takamatu/.local/state/nix/profiles/profile/
|   |-- bin/
|   |-- etc/
|   |-- lib/
|   |-- libexec/
|   |-- sbin/
|   `-- share/
|-- .nix-channels
```

### 参考

- [Nix Home Manager のつまづき石をまとめる ||| Apribase](https://apribase.net/2023/08/22/nix-home-manager-qa/)
