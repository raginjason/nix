{ config, pkgs, ... }:

let
  common = import ../personal/default.nix { inherit config pkgs; };
in
{
  programs.git = common.programs.git // {
    userEmail = "jason.walker@fanduel.com";
  };

  home.stateVersion = common.home.stateVersion;
}
