{
  description = "TA-Lib development environment";

  inputs = rec {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-master.url = "nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-master
    , flake-utils
    , devshell
    , ...
    }@inputs:
    {
      overlays.default = import ./overlay.nix;
    } //
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        packageName = "ta-lib";
        overlays = [
          devshell.overlays.default
        ];

        pkgs = import nixpkgs {
          inherit system overlays;
        };

        ta-lib = pkgs.callPackage ./default.nix { };

        shellPackages = with pkgs; [
        ];

        buildInputs = with pkgs; [
        ];

        lib-path = with pkgs; lib.makeLibraryPath buildInputs;
      in
      {
        devShell = pkgs.devshell.mkShell {
          commands = [
            {
              help = "clear screen";
              name = "cls";
              command = "clear";
            }
          ];

          env = [
          ];

          devshell.startup.init1.text = ''
            # Augment the dynamic linker path
            export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
          '';

          devshell.packages = shellPackages;
        };

        packages = {
          default = ta-lib;
        };

      }
      );
}
