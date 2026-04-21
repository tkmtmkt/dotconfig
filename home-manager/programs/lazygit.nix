{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;

    # 共通設定 (config.yml に反映される内容)
    settings = {
      git = {
        pagers = [
          # Gitのdiffにdeltaを使用する場合の例
          {
            colorArg = "";
            pager = "delta --dark --paging=never";
          }
        ];
        # コミットメッセージの表示などに使用する設定
        useConfig = true;
      };
      gui = {
        # Nerd Font前提の表示を有効化
        nerdFontsVersion = "3"; # 最近のNerd Fontsはv3系
        showIcons = true;
        showFileTree = true;
        theme = {
          activeBorderColor = [ "cyan" "bold" ];
          inactiveBorderColor = [ "white" ];
        };
      };
    };
  };
}
