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

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

        userSettings = {
          files.autoSave = "onFocusChange";
        };

      profiles.default.extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];
    };

    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;

      settings = {
        theme = "Dark Modern";
        font-family = "JetBrainsMono Nerd Font";
        font-style  = "Regular";
        font-size   = 13;
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

    programs.zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "aws"
          "docker"
          "gcloud"
          "gh"
          "git"
          "golang"
          "kubectl"
          "minikube"
        ];
      };

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ff  = "fastfetch";
        lzd = "lazydocker";
        lzg = "lazygit";
        open = "xdg-open";
        vim = "nvim";
        zed = "zeditor";

        docker-disable = "sudo systemctl disable docker.service docker.socket && echo \"🚫 Docker disabled at boot\"";
        docker-enable  = "sudo systemctl enable docker.service docker.socket && echo \"✅ Docker enabled at boot\"";
        docker-down    = "sudo systemctl stop docker.service docker.socket && echo \"🛑 Docker stopped\"";
        docker-restart = "sudo systemctl restart docker.service && echo \"🔁 Docker restarted\"";
        docker-up      = "sudo systemctl start docker.service docker.socket && echo \"🐳 Docker started\"";
        docker-status  = "systemctl status docker.service --no-pager";

        postgres-up = "sudo docker run -d --restart unless-stopped -p 127.0.0.1:5432:5432 --name=postgres18 -e POSTGRES_HOST_AUTH_METHOD=trust -v postgres18-data:/var/lib/postgresql postgres:18";
        psql-local = "psql -h localhost -U postgres";
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 5;
        };
        "org/gnome/desktop/wm/keybindings" = {
          toggle-fullscreen = ["<Super>f"];
          close = ["<Super>w"];
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
        "org/gnome/desktop/interface" = {
          gtk-theme = "Adwaita-dark";
          icon-theme = "Adwaita";
          color-scheme = "prefer-dark";
          clock-format = "12h";
        };
        "org/gnome/mutter" = {
          dynamic-workspaces = false;
          experimental-features = [
            "scale-monitor-framebuffer"
            "xwayland-native-scaling"
          ];
        };
        "org/gnome/desktop/interface" = {
          enable-animations = true;
          show-battery-percentage = true;
        };
        "org/gnome/shell" = {
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "dash-to-dock@micxgx.gmail.com"
          ];
          favorite-apps  = [
            "google-chrome.desktop"
            "org.gnome.Nautilus.desktop"
            "codium.desktop"
            "com.mitchellh.ghostty.desktop"
          ];
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-timeout = 900;
          sleep-inactive-battery-timeout = 1800;
        };
        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [];
          switch-to-application-2 = [];
          switch-to-application-3 = [];
          switch-to-application-4 = [];
          switch-to-application-5 = [];
          switch-to-application-6 = [];
          switch-to-application-7 = [];
          switch-to-application-8 = [];
          switch-to-application-9 = [];
          open-new-window-application-1 = [];
          open-new-window-application-2 = [];
          open-new-window-application-3 = [];
          open-new-window-application-4 = [];
          open-new-window-application-5 = [];
          open-new-window-application-6 = [];
          open-new-window-application-7 = [];
          open-new-window-application-8 = [];
          open-new-window-application-9 = [];
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" "<Super>0" ];
          move-to-workspace-1 = [ "<Super><Shift>1" ];
          move-to-workspace-2 = [ "<Super><Shift>2" ];
          move-to-workspace-3 = [ "<Super><Shift>3" ];
          move-to-workspace-4 = [ "<Super><Shift>4" ];
          move-to-workspace-5 = [ "<Super><Shift>5" "<Super><Shift>0" ];
        };
        "org/gnome/shell/extensions/dash-to-dock" = {
          hot-keys = false;
        };
      };
    };
  };
}
