{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    # package = pkgs.yazi; # 必要に応じて特定のバージョンを指定
    shellWrapperName = "y"; # デフォルトの "yy" を "y" に変更

    # yazi.toml の設定
    settings = {
      manager = {
        show_hidden = true;
        # 自然順ソート（file1, file2, file10 の順になる）
        sort_by = "natural";
        # ディレクトリを先に、ファイルを後に表示
        sort_dir_first = true;
      };
      preview = {
        image_filter = "nearest";
      };
      # テーマの適用
      theme = {
        flavor = {
          name = "vscode-dark-modern";
        };
      };
    };

    # keymap.toml の設定 (キーバインド)
    keymap = {
      manager.prepend_keymap = [
        { on = "j"; run = "arrow 1"; desc = "Move cursor down"; }
        { on = "k"; run = "arrow -1"; desc = "Move cursor up"; }
        # 選択したファイル/ディレクトリをゴミ箱に移動
        { on = [ "d" "d" ]; run = "remove"; desc = "ゴミ箱に移動"; }
        # ファイル/ディレクトリのパスをクリップボードにコピー
        { on = [ "y" "p" ]; run = "shell 'printf \"%s\" $0 | pbcopy' --orphan"; desc = "パスをクリップボードにコピー"; }
      ];
    };

    # テーマ (flavors) のインストール
    flavors = {
      vscode-dark-modern = pkgs.fetchFromGitHub {
        owner = "956MB";
        repo = "vscode-dark-modern.yazi";
        rev = "main"; # または特定のコミットハッシュ
        #sha256 = "sha256-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=";
        sha256 = "sha256-ErlGclqCIvb3P0nhznJJ3QbWJpiCzQJzOFxAzC+pxVw=";
      };
    };
  };
}
