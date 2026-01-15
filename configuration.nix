# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-e08190a4-c01b-48ff-b20e-87f82a33ecbf".device = "/dev/disk/by-uuid/e08190a4-c01b-48ff-b20e-87f82a33ecbf";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Amman";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.abdulrahman = {
    isNormalUser = true;
    description = "abdulrahman";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget\
  environment = {
    systemPackages = with pkgs; [
      git
      google-chrome
      vscodium
      wget
      wl-clipboard
      tldr
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

  # TODO: git username, email, default branch main

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
