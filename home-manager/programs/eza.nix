{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    # lsとオプションが異なるので使用しない
    #enableBashIntegration = true;
    extraOptions = [
      "--header"
      "--git"
      #"--time-style=long-iso"
      "--time-style=+%F %T %Z"
    ];
  };
}
