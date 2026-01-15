{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.luks.devices."luks-e08190a4-c01b-48ff-b20e-87f82a33ecbf".device = "/dev/disk/by-uuid/e08190a4-c01b-48ff-b20e-87f82a33ecbf";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Amman";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
    xserver.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

  users.users.abdulrahman = {
    isNormalUser = true;
    description = "abdulrahman";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      google-chrome
      home-manager
      kubectl
      lazydocker
      lazygit
      minikube
      tldr
      vscodium
      wget
      wl-clipboard
      zsh

      gnomeExtensions.dash-to-dock
      gnomeExtensions.appindicator
    ];

    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-calendar
      gnome-connections
    ];
  };

  programs.zsh = {
    enable = true;

    ohMyZsh = {
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

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
      lzg = "lazygit";
      lzd = "lazydocker";
      ff  = "fastfetch";
      open = "xdg-open";

      docker-disable = "sudo systemctl disable docker.service docker.socket && echo \"🚫 Docker disabled at boot\"";
      docker-enable  = "sudo systemctl enable docker.service docker.socket && echo \"✅ Docker enabled at boot\"";
      docker-down    = "sudo systemctl stop docker.service docker.socket && echo \"🛑 Docker stopped\"";
      docker-restart = "sudo systemctl restart docker.service && echo \"🔁 Docker restarted\"";
      docker-up      = "sudo systemctl start docker.service docker.socket && echo \"🐳 Docker started\"";
      docker-status  = "systemctl status docker.service --no-pager";

      postgres-up = ''
        sudo docker run -d --restart unless-stopped \
          -p "127.0.0.1:5432:5432" \
          --name=postgres18 \
          -e POSTGRES_HOST_AUTH_METHOD=trust \
          -v postgres18-data:/var/lib/postgresql \
          postgres:18
      '';

      psql-local = "psql -h localhost -U postgres";
    };

    shellInit = ''
      export EDITOR=nvim
      export PATH="$PATH:$HOME/.local/bin"
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.dconf.enable = true;
  system.stateVersion = "25.11";
}
