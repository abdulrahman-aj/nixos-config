{ config, pkgs, ... }:

{
  home-manager.users.abdulrahman = {
    home = {
      homeDirectory = "/home/abdulrahman";
      stateVersion = "25.11";
    };

    programs.git = {
      enable = true;
      settings = {
        user.name = "abdulrahman-aj";
        user.email = "ajlouni2000@gmail.com";
        init.defaultBranch = "main";
      };
    };

    dconf.enable = true;

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "'Adwaita-dark'";
        icon-theme = "'Adwaita'";
        color-scheme = "'prefer-dark'";
      };
    };
  };
}
