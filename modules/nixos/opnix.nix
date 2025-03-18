{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    strings
    ;
  cfg = config.local.opnix;
in
{
  options.local.opnix = {
    enable = mkEnableOption "Enable 1Password secrets on the host";

    configFile = mkOption {
      type = types.path;
      default = false;
      description = "Source of secrets config file";
    };
  };

  imports = [ inputs.opnix.nixosModules.default ];

  config = mkIf cfg.enable {
    services.onepassword-secrets = {
      enable = true;
      users = [ config.crossSystem.username ];  # Users that need secret access
      tokenFile = "/etc/opnix-token";  # Default location
      configFile = cfg.configFile;
      # configFile = "/path/to/your/secrets.json";
      outputDir = "/var/lib/opnix/secrets";  # Optional, this is the default
    };
  };
}
