{ pkgs, ... }:
{
  programs.delta = {
    enable = true;
    options = {
      # Deltaの機能設定を記述
      line-numbers = true;
      side-by-side = true;
      syntax-theme = "Visual Studio Dark+";
    };
  };
}
