{ config, pkgs, ... }:

{
  programs.git = {
    userEmail = "jason.walker@fanduel.com";
    signing.key = "1B17DF9CE0FF984A7BE2F033D7EF114F30003F59";
  };

  home.stateVersion = "24.11";
}
