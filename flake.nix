{
  description = "Named flakes for different DevContainer environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-linux"; # Adjust for your architecture
      pkgs = import nixpkgs { inherit system; };

      # Detect the user dynamically, with a fallback
      username = builtins.getEnv "USER";
      homeDir = builtins.getEnv "HOME";

      # Function to create a home-manager configuration
      mkHomeConfig = name: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/${name}/default.nix
          {
            home.username = if username != "" then username else "vscode";
            home.homeDirectory = if homeDir != "" then homeDir else "/home/vscode";
          }
        ];
      };

      # Function to create a dev shell environment
      mkDevShell = name: pkgs.mkShell {
        name = "${name}-devcontainer-env";
        buildInputs = with pkgs; [
          git
          curl
          jq
          bashInteractive
        ];
        shellHook = ''
          echo "Welcome to the ${name} DevContainer environment!"
        '';
      };
      
    in {
      # Named home-manager configurations
      homeConfigurations = {
        personal = mkHomeConfig "personal";
        fanduel = mkHomeConfig "fanduel";
        projectX = mkHomeConfig "projectX";
      };

      # Named development environments
      devShells.${system} = {
        personal = mkDevShell "personal";
        fanduel = mkDevShell "fanduel";
        projectX = mkDevShell "projectX";
      };

      # Runnable switch scripts for each named flake
      packages.${system} = {
        personal-switch = pkgs.writeShellScriptBin "nix-switch-personal" ''
          nix develop --impure
          home-manager switch --flake .#personal
        '';

        fanduel-switch = pkgs.writeShellScriptBin "nix-switch-fanduel" ''
          nix develop --impure
          home-manager switch --flake .#fanduel
        '';

        projectX-switch = pkgs.writeShellScriptBin "nix-switch-projectX" ''
          nix develop --impure
          home-manager switch --flake .#projectX
        '';
      };
    };
}
