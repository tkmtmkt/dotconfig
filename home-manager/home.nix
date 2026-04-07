{ config, pkgs, ... }:

let
  # 環境変数を取得するためnix実行時に--impureオプションを指定する
  username = builtins.getEnv "USER";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

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
    # 代替コマンド
    bat                 # catの代替コマンド
    dust                # duの代替コマンド
    hexyl               # odの代替コマンド
    hyperfine           # timeの代替コマンド
    procs               # psの代替コマンド
    # 開発用ツール
    devbox              # 開発環境構築ツール
    # その他ツール
    bash-completion     # bash環境用のコマンド入力補完
    bc                  # 計算機
    byobu               # ターミナルマルチプレクサ
    fio                 # ディスク性能テストツール
    git                 # バージョン管理ツール
    libxml2             # XMLファイルの解析、整形、検証ツール
    lnav                # ログビューア
    p7zip               # ファイルアーカイバ
    powershell          # PowerShell
    pwgen               # ランダムなパスワードを生成するコマンド
    tig                 # ターミナル上でgit操作を行うためのCUIツール
    tmux                # ターミナルエミュレータ
    tree                # ディレクトリ構造表示ツール

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
    ".profile".force = true;
    ".profile".source = dotfiles/_profile;
    ".config/git/config".force = true;
    ".config/git/config".source = dotfiles/_config/git/config;
    ".config/git/exclude".force = true;
    ".config/git/exclude".source = dotfiles/_config/git/exclude;
    ".config/tig/config".force = true;
    ".config/tig/config".source = dotfiles/_config/tig/config;
    ".config/tmux/tmux.conf".force = true;
    ".config/tmux/tmux.conf".source = dotfiles/_config/tmux/tmux.conf;

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
  #  /etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # 代替コマンド
  programs.bottom.enable = true;        # topの代替コマンド
  programs.delta.enable = true;         # diffの代替コマンド
  programs.eza.enable = true;           # lsの代替コマンド
  programs.fd.enable = true;            # findの代替コマンド
  programs.htop.enable = true;          # topの代替コマンド
  programs.ripgrep.enable = true;       # grepの代替コマンド

  # 開発用ツール
  programs.direnv = {                   # direnvのシェル統合設定
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  programs.uv.enable = true;            # Pythonパッケージ管理ツール

  # その他ツール
  programs.jq.enable = true;            # JSONデータ処理ツール
  programs.lazygit.enable = true;       # ターミナル上で動作する高速・軽量なGitクライアント（TUI）
  programs.parallel.enable = true;      # 並列実行コマンド
  programs.vifm.enable = true;          # ファイルマネージャ
  programs.vim = {                      # Vim設定
    enable = true;
    plugins = with pkgs.vimPlugins; [
      SudoEdit-vim
      ale
      asyncomplete-lsp-vim
      asyncomplete-vim
      context_filetype-vim
      editorconfig-vim
      nerdtree
      tcomment_vim
      vim-airline
      vim-airline-clock
      vim-airline-themes
      vim-colorschemes
      vim-fugitive
      vim-indent-guides
      vim-lsp
      vim-lsp-settings
      vim-surround
      vim-vsnip
      vim-vsnip-integ
      vimagit
    ];
    extraConfig = builtins.readFile ./extra/vimrc.vim;
  };
  programs.zoxide = {                   # zoxideのシェル統合設定
    enable = true;
    enableBashIntegration =true;
    options = [
      "--cmd cd"
    ];
  };
}
