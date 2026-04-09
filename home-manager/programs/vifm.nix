{ pkgs, ... }:
{
  programs.vifm = {
    enable = true;
    # 設定内容を直接記述する場合 (vifmrc の内容)
    extraConfig = ''
      set trash
      set timefmt=" %Y/%m/%d %H:%M:%S %Z"
      set statusline="  %t  [%T]%= %A %10u:%-7g %15s %20d [%a free]"
      set viewcolumns=-45%{name}..,-{ext},10{size},12{perms},21{mtime}
      set sizefmt=units:iec,precision:3
    '';
  };
}
