{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        pythonVersion =
          let
            content = builtins.readFile ./Pipfile;
            version = builtins.head (builtins.match ".*python_version = \"([^\"]+)\".*" content);
            versionWithoutDot = builtins.replaceStrings ["."] [""] version;
            pythonPkgName = "python${versionWithoutDot}";
          in
            pythonPkgName;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.${pythonVersion}
            pkgs.pipenv
          ];
        };
      });
}
