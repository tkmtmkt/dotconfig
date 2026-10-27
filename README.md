# dotconfig

## 概要
このリポジトリは、NixエコシステムのツールであるHome Managerを利用して、
ユーザ環境（パッケージおよび各種設定）を宣言的に管理するための構成をまとめたものです。

シェル、エディタ、Gitなどの設定をモジュール単位で分割し、`home.nix`からインポートする
構成を採用しています。
これにより、設定の再利用性と可読性を高めつつ、環境の再現性を確保しています。

## 背景
従来のdotfiles管理では、以下のような課題がありました：

* 環境構築手順が手動になりがちで再現性が低い
* パッケージ管理と設定管理が分離している
* 複数マシン間での同期が煩雑

これらの課題を解決するため、NixおよびHome Managerを採用し、環境構築をコードとして管理する方針に移行しました。

また、設定を機能ごとに分割することで、以下のメリットを得ています：

* 設定の見通しが良くなる
* 必要なモジュールのみを選択して利用できる
* 将来的な構成拡張が容易

## 技術スタック
以下のツールを使用しています。

* nix
* home-manager

## セットアップ
リポジトリをクローンします：

```sh
git clone git@github.com:tkmtmkt/dotconfig.git ~/.config
```

NixをインストールしてHome Managerを適用します：

```sh
~/.config/home-manager/bin/setup.sh
```

セットアップをやり直す場合：

```sh
rm -rf ~/.local/state/nix
~/.config/home-manager/bin/setup.sh
```

## 使い方

### カスタマイズ

* パッケージの追加：`home.nix` または該当モジュール内の `home.packages`
* 各種設定の変更：対応するモジュールファイルを編集

変更後は以下を実行して反映します：

```bash
~/.config/home-manager/bin/home-manager-switch.sh
```

### アップデート

```sh
# Nixパッケージ更新
~/.config/home-manager/bin/nix-flake-update.sh
```

## 補足

### リポジトリ内容
```
${HOME}
|-- .config/
|   |-- home-manager/
|   |   |-- bin/
|   |   |   |-- home-manager-switch.sh*
|   |   |   |-- backup-nix.sh*
|   |   |   |-- nix-flake-update.sh*
|   |   |   |-- nix-store-gc.sh*
|   |   |   |-- restore-nix.sh*
|   |   |   `-- setup.sh*
|   |   |-- dotfiles/
|   |   |   `-- *****           # アプリケーション設定ファイルを配置
|   |   |-- programs/
|   |   |   `-- *****           # アプリケーション毎の設定用Nixファイルを配置
|   |   |-- flake.lock
|   |   |-- flake.nix
|   |   `-- home.nix
|   |-- nix/
|   |   `-- nix.conf            # Nix設定ファイル
|   |-- .gitignore
|   `-- README.md
```

* `home.nix`
  エントリーポイントとなる設定ファイル。各モジュールを`imports`で読み込みます。
* `programs/*.nix`
  アプリケーションや用途ごとの設定ファイルです。パッケージ単位で分割しています。

### 実行環境のファイル構成
```
/
|-- nix/
|   |-- store/
|   `-- var/
|       `-- nix/
|           `-- gcroots/
`-- ${HOME}/
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
    |-- .nix-defexpr/           # 使用しない(Flakes以前の方式で使用していたもの)
    |-- .nix-profile -> ${HOME}/.local/state/nix/profiles/profile/
    |   |-- bin/                # 追加したパッケージの実行ファイルへのシンボリックリンクが格納される
    |   |-- etc/
    |   |   `-- profile.d/
    |   |       `-- nix.sh      # Nix環境設定ファイル
    |   |-- lib/
    |   |-- libexec/
    |   |-- sbin/
    |   `-- share/
    `-- .nix-channels           # 使用しない(Flakes以前の方式で使用していたもの)
```

### Nix操作
```sh
# Nixインストール
sudo mkdir -p -m 0755 /nix
sudo chown ${USER}:${USER} /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Nixを更新する
nix profile upgrade nix

# パッケージ一覧
nix profile list

# パッケージを検索する
nix search nixpkgs#パッケージ名 ^

# パッケージを追加する
nix profile add nixpkgs#パッケージ名

# パッケージを更新する
nix profile upgrade パッケージ名

# パッケージを削除する
nix profile remove パッケージ名

# Nixストアのガベージコレクション
nix store gc

# 古い世代や不要なパッケージを削除する
nix-collect-garbage --delete-old

# GC root(GCの起点となるオブジェクトやパス)の一覧
nix-store --gc --print-roots
```

### home-manager の仕組み

インストールコマンドである `nix run home-manager switch` を実行すると、
内部では以下の処理を行います。

- flake.nix + home.nix から home-manager-path(ツール・コマンドの集まり)、
  home-manager-files(設定ファイルの集まり)を作成します。
- home-manager-path, home-manager-files から home-manager-generation(環境全体の完成形) を作成します。
- home-manager-generation/activate を実行して環境を適用します。

## 参考
- [Nix Home Manager のつまづき石をまとめる ||| Apribase](https://apribase.net/2023/08/22/nix-home-manager-qa/)
