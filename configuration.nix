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
      awscli2
      clang
      discord
      fastfetch
      fd
      fzf
      gh
      ghostty
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      go
      google-chrome
      google-cloud-sdk
      home-manager
      jq
      kubectl
      lazydocker
      lazygit
      minikube
      nodejs
      nerd-fonts.jetbrains-mono
      openjdk
      postgresql
      python3
      ruby
      sqlc
      sqlite
      tldr
      vscodium
      wget
      wl-clipboard
      zsh
    ];

    gnome.excludePackages = with pkgs; [
      gnome-calendar
      gnome-connections
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-tour
    ];
  };

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  system.stateVersion = "25.11";
}
