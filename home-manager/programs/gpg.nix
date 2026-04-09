{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    settings = {
      # 必要に応じて設定を追加
      keyserver = "hkps://keys.openpgp.org";
    };
  };
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800; # キャッシュ時間
    enableSshSupport = true; # SSHサポートを有効にする場合
  };
}
