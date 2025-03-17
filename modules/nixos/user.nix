{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    mkDefault
    mkForce
    ;
  inherit (lib.types) nullOr str;
  cfg = config.mainUser;
in
{
  imports = [ ../common/packages ];

  options.mainUser = {
    enable = mkEnableOption "Enable the main user";
    username = mkOption {
      type = nullOr str;
      default = "ammmze";
      description = "Username for the main user";
    };
    email = mkOption;
    fullName = mkOption;
  };

  config = mkIf cfg.enable {
    users.users.${config.mainUser.username} = {
      isNormalUser = true;
      group = "users";
      extraGroups = mkDefault [ "wheel" ];
      shell = mkForce pkgs.zsh;
      hashedPassword = mkDefault "$y$j9T$WycD6P4Q4gRVswNn9z4XO/$YhfyMrN6N26c2nhUNexTZigXz5qjIBCYbIF/lMnZXg9";
      openssh.authorizedKeys.keys = [ config.crossSystem.sshPubKey ];
    };

    security.sudo.extraRules = [
      {
        users = mkDefault [ config.crossSystem.username ];
        runAs = "ALL:ALL";
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];

    programs.zsh.enable = true;
  };
}
