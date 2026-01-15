{ config, pkgs, ... }:

{
  home-manager.backupFileExtension = "backup";

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

    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;

      settings = {
        theme = "Catppuccin Mocha";
        font-family = "JetBrainsMono Nerd Font";
        font-style  = "Regular";
        font-size   = 12;
        window-theme          = "ghostty";
        window-padding-x      = 0;
        window-padding-y      = 0;
        confirm-close-surface = false;
        resize-overlay        = "never";
        gtk-toolbar-style     = "flat";
        cursor-style       = "block";
        cursor-style-blink = false;
        shell-integration-features = ["no-cursor" "ssh-env"];
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          gtk-theme = "Adwaita-dark";
          icon-theme = "Adwaita";
          color-scheme = "prefer-dark";
        };
        "org/gnome/shell" = {
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "dash-to-dock@micxgx.gmail.com"
          ];
        };
      };
    };
  };
}
