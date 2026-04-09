{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      # テーマの設定 (例: TwoDark, 1337)
      theme = "Visual Studio Dark+";
      # ファイル拡張子とシンタックスのマップ
      map-syntax = [
        "*.h:C++"
        ".ignore:Git Ignore"
      ];
      # 表示スタイル
      #style = "grid,header,numbers,changes";
      style = "full";
    };
  };
}
