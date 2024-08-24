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

          # Roswell: Implentation and Dependancy management
          roswell

          # Implementations
          sbcl # Steel Banks Common Lisp
          abcl # Armed Bear Common Lisp
          ccl  # Clozure Common Lisp
          ecl  # Embeded Common Lisp
        ];

        EDITOR = "emacs";

        # We need to provide the paths to the libraries needed by some packages that use CFFI
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs;[
          openssl # for hunchentoot
          libev   # for woo
        ]);
      };
    };
  };
}
