{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jason Walker";
    userEmail = "ragin.jayson@me.com";
    extraConfig = {
      core.editor = "vim";
      color.ui = "auto";
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.stateVersion = "24.11";
}
