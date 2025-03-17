{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  networking = {
    hostName = mkDefault "nixos";
    nameservers = mkDefault [ "1.1.1.1" "8.8.8.8" ];
    # domain = mkDefault "packnet.cc";
  };
}
