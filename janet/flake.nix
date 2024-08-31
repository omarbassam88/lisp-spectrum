{
  description = "
  A minimal flake to get you started with Common Lisp
  Created by the Lisp Spectrum Project
  You can run a development shell using the command 'nix develop'";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux"; # Change if using something other than linux
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = {
      default = pkgs.mkShell {
        packages = with pkgs; [
          # Emacs is the defacto standard for working with Lisp
          emacs

          janet
          jpm

        ];

        EDITOR = "emacs";

        JANET_LIBPATH = pkgs.lib.makeLibraryPath [ pkgs.janet ];

      };
    };
  };
}
