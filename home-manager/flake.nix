{
  description = "Home Manager configuration";

  inputs = {
    # Home ManagerとNixpkgsのソースを指定してください。
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # 環境変数を取得するためnix実行時に--impureオプションを指定する
      username = builtins.getEnv "USER";
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # ここにホーム設定モジュールを指定してください。
        # 例えば、home.nixへのパスなどです。
        modules = [ ./home.nix ];

        # オプションとして extraSpecialArgs を使用して、
        # 引数を home.nix に渡します。
      };
    };
}
