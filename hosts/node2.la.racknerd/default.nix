{ config, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    # TODO: replace with disk-config
    ./hardware-configuration.nix
    # ./disk-config.nix
    # ./incus.nix
  ];

  networking = {
    hostName = "node2";
    domain = "la.racknerd.cashmedia.me";
  };

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/vda";
    };
    # loader.systemd-boot.enable = true;
    # loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    useDHCP = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        # 8443
        # 53
        # 67
        22
      ];
      allowedUDPPorts = [
        # 53
        # 67
      ];
    };
  };

  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
    logrotate.checkConfig = false;
  };

  mainUser.enable = true;

  system.stateVersion = "24.11";
}
