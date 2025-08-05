# flake.nix
{
  description = "Nix dev env for node.js";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

      in
      {
        devShells.default = pkgs.mkShell {
          # Add build tools for native Node.js addons like sqlite3
          nativeBuildInputs = [
            pkgs.pkg-config
            pkgs.gcc
          ];

          # Runtime packages available in the shell
          packages = [
            pkgs.nodejs-20_x
            pkgs.pnpm
            pkgs.sqlite
            pkgs.git
          ];

          shellHook = ''
                        clear
            echo "+===[▌▌▌ ================================= ▌▌▌]===+"
            echo "              |    nix ❤️ node.js   |"
            echo "+===[▌▌▌ ================================= ▌▌▌]===+"
            echo ""
            echo "  ✰ Node.js ready:     $(node --version)"
            echo "  ✰ pnpm ready:        v$(pnpm --version)"
            echo "  ✰ SQLite ready:      $(sqlite3 --version)"
            echo ""
            echo "  Next Steps:"
            echo "  ✰ $ 'pnpm install'"
            echo "  ✰ $ 'pnpm start'"
            echo ""
            echo "+===[▌▌▌ ================================= ▌▌▌]===+"
          '';
        };
      });
}