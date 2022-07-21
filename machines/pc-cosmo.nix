# Machine-specific configuration for `pc-cosmo`.
{ config, pkgs, modulesPath, ... }: {

  # Boot.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  # Time Zone, Locale, etc.
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.utf8";

  # Networking.
  networking.hostname = "pc-cosmo";

  # Stateful Migrations.
  #
  # NOTE:
  # This value should correspond to the version of NixOS that was used for this
  # machine's initial installation, and should not change during the machine's
  # lifetime.
  #
  # The only time this should change is after a machine is destroyed (i.e. the
  # system disk is wiped or replaced) and a clean NixOS installation is deployed.
  system.stateVersion = "22.05";
}
