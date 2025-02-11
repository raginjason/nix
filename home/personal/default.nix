{ config, pkgs, ... }:

{
  programs.git = {
    userEmail = "ragin.jason@me.com";
    signing.key = "8E875E4D66418E635D68B82C87BF4D46349DD25F";
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.stateVersion = "24.11";
}
