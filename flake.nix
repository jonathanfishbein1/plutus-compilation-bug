{
  description = "plutus-template";

  nixConfig = {
    extra-substituters = "https://horizon.cachix.org";
    extra-trusted-public-keys = "horizon.cachix.org-1:MeEEDRhRZTgv/FFGCv3479/dmJDfJ82G6kfUDxMSAw0=";
  };

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    horizon-plutus.url = "git+https://github.com/jonathanfishbein1/horizon-plutus";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    inputs@{ self
    , flake-utils
    , horizon-plutus
    , nixpkgs
    , ...
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs { inherit system; };
      hsPkgs =
        with pkgs.haskell.lib;
        horizon-plutus.legacyPackages.${system}.extend (hfinal: hprev:
          {
            plutus-template = disableLibraryProfiling (hprev.callCabal2nix "plutus-template" ./. { });
          });
    in
    {
      devShells.default = hsPkgs.plutus-template.env.overrideAttrs (attrs: {
        buildInputs = attrs.buildInputs ++ [
          hsPkgs.cabal-install
          pkgs.nixpkgs-fmt
        ];
      });
      packages.default = hsPkgs.plutus-template;
    });
}
