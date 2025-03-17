{ lib, ... }:
{
  options.crossSystem = lib.mkOption {
    type = lib.types.attrs;
    default = {
      username = "ammmze";
      sshPubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOIyelkmaDV3ESgl741cFhifVRoMxb2ibRHoToEbApd common";
    };
  };
}
