{ config, pkgs, ... }:

{
  imports = [
    # Include hardware configuration generated by NixOS.
    # Hardware configuration is generated automatically and should never be
    # modified manually.
    #
    # To regenerate the config, run `sudo nixos-generate-config`.
    #
    # Make sure you stage this file (`git add hardware-configuration.nix`) so
    # that Nix can see it when rebuilding with flakes.
    #
    # See the _Bootstrap_ section of `README.md` for more information and
    # detailed instructions.
    ./hardware-configuration.nix
  ];

  # Experimental Nix options.
  #
  # Enables:
  # - `flakes`: allow usage of Nix flakes to improved configuration composition and reproducibility.
  nix.extraOptions = ''
    experimental-features = flakes
  '';

  # General settings.
  nixpkgs.config.allowUnfree = true; # Allow non-free software packages.
  networking.networkmanager.enable = true;

  # Sound settings.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # GNOME Desktop.
  #
  # Even though Wayland is used by default on GNOME 42, the settings we need
  # are under the `xserver` service for legacy reasons.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "";
  environment.gnome.excludePackages = [
    pkgs.epiphany
    pkgs.gnome-console
    pkgs.gnome-user-docs
    pkgs.gnome-tour
  ];

  # System packages.
  environment.systemPackages = with pkgs; [
    # Low level system administration utilities.
    vim
    nano
    wget
    curl
    git

    # Development
    rustup
    cargo
    rustc
    nodejs-16_x
    yarn
    python310

    # Performance profiling, monitoring, etc.
    glxinfo

    # Desktop applications.
    gnome.gnome-terminal

    # Multimedia.
    gimp
  ];

  # SSH.
  services.openssh.enable = true;

  # Steam.
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;

  # User accounts.
  users.users.joe = {
    isNormalUser = true;
    description = "Joe D'Amore";
    extraGroups = [ "networkmanager" "wheel" ];
    # TODO Explore using Home Manager for `joe` user packages.
    packages = with pkgs; [
      # General usage.
      (pkgs.firefox.overrideAttrs (oldAttrs: {
        desktopItem.desktopName = "Firefox";
      }))
      firefox-wayland
      google-chrome
      thunderbird

      # Gaming and emulation.
      mupen64plus        # Nintendo 64 emulation
      melonDS            # Nintendo DS emulation
      dolphin-emu-beta   # Nintendo GameCube/Wii emulation
      yuzu-mainline      # Nintendo Switch emulation
      duckstation        # PlayStation 1 emulation
      pcsx2              # PlayStation 2 emulation

      # Dev tools.
      sublime4
      sublime-merge
      gh
    ];
  };
}
