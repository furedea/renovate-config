{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, ... }:
    let
      # CI runs on x86_64-linux; local development is on aarch64-darwin.
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      mkDevShell =
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.mkShell {
          packages = with pkgs; [
            commitlint
            deadnix
            # lefthook before 2.1.6 runs hooks under a pty, which agent sandboxes deny.
            nixpkgs-unstable.legacyPackages.${system}.lefthook
            ls-lint
            nixfmt
            renovate
            statix
            # Add language toolchain here (uv, pnpm, cargo, go, ...).
          ];
        };
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (system: {
        default = mkDevShell system;
      });
    };
}
