# NixOS General Config
NixOS configuration for my general purpose desktop PCs.

## Overview

## Usage

### Bootstrap
These instructions explain how to apply this configuration for the first time.

#### Prerequisites
1. A configuration in `flake.nix` and `./machines` that is applicable to the machine you wish to bootstrap
2. A working `NixOS` install on the desired machine
    - See [Download NixOS](https://nixos.org/download.html#download-nixos) for installer images
3. A way to transfer the contents of this repository to the desired machine
    - If you have `git` installed, you can simply clone this repo to `/etc/nixos`, being sure to keep and stage the existing `hardware-configuration.nix` file.
    - Otherwise, you can transfer the project using a USB drive, SSH, etc.

## Machines
Machine-specific configuration files are stored in the `./machines` directory. When rebuilding the system, the desired configuration can be selected using the machine names listed below.

Example:
```bash
sudo nixos-rebuild switch --flake .#<machine name>
```

The configuration files in `./machines` include machine-specific configurations (network hostname, system state version) and import any modules required by the machine (generally to support hardware or accessories that may not be present on other machines).

### Desktop PCs
Desktop PCs (physical devices) that can be used for gaming, development, and general purpose computing. Names are prefixed `pc-` and are based on character names from _The Fairly Oddparents_.

| Name<sup>\*</sup> | Description                                 |
|-------------------|---------------------------------------------|
| `pc-cosmo`        | Gaming, development, and general purpose PC |
