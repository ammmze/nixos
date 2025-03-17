{ lib, ... }:
{
  time.timeZone = lib.mkDefault "America/Phoenix";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
}
