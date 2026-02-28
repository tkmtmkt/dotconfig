{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "takamatu";
  home.homeDirectory = "/home/takamatu";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    bat                 # catの代替コマンド
    fd                  # findの代替コマンド
    fio                 # ディスク性能テストツール
    git                 # バージョン管理ツール
    hexyl               # odの代替コマンド
    htop                # topの代替コマンド
    lnav                # ログビューア
    p7zip               # ファイルアーカイバ
    procs               # psの代替コマンド
    pwgen               # ランダムなパスワードを生成するコマンド
    ripgrep             # grepの代替コマンド
    tig                 # gitブラウザ
    tmux                # ターミナルエミュレータ
    tree                # ディレクトリ構造表示ツール
    uv                  # Pythonパッケージ管理ツール
    vifm                # ファイルマネージャ
    vim                 # テキストエディタ

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".bash_aliases".force = true;
    ".bash_aliases".source = dotfiles/_bash_aliases;
    ".bash_profile".force = true;
    ".bash_profile".source = dotfiles/_bash_profile;
    ".bashrc".force = true;
    ".bashrc".source = dotfiles/_bashrc;
    ".gitconfig".force = true;
    ".gitconfig".source = dotfiles/_gitconfig;
    ".gitexclude".force = true;
    ".gitexclude".source = dotfiles/_gitexclude;
    ".profile".force = true;
    ".profile".source = dotfiles/_profile;
    ".tigrc".force = true;
    ".tigrc".source = dotfiles/_tigrc;
    ".tmux.conf".force = true;
    ".tmux.conf".source = dotfiles/_tmux.conf;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/takamatu/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
