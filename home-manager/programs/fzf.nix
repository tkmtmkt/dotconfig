{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;

    # fzfのデフォルトオプション
    defaultOptions = [
      "--height 20%"
      "--layout=reverse"
      "--border"
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];

    # コマンドのエイリアス設定
    changeDirWidgetCommand = "fd --type d";
    fileWidgetCommand = "fd --type f";
  };
}
