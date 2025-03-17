{ lib, ... }:
{
  services = {
    openssh = lib.mkDefault {
      enable = true;
      settings = {
        # TODO: un-comment these eventually...but for now still experimenting
        # PasswordAuthentication = false;
        # KbdInteractiveAuthentication = false;
      };
    };
  };
}
