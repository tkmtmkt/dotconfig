### 初期設定

```
# Nixインストール
$ sh <(curl -L https://nixos.org/nix/install) --no-daemon
$ . ~/.nix-profile/etc/profile.d/nix.sh
$ nix --version

# home-manager有効化
$ nix run home-manager switch
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
```

### home-manager管理

```sh
# パッケージ一覧
$ home-manager packages
```
