{ config, ... }:
{
  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "ens3";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.11.12.2/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      # postSetup = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.11.12.0/24 -o eth0 -j MASQUERADE
      # '';

      # This undoes the above command
      # postShutdown = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.11.12.0/24 -o eth0 -j MASQUERADE
      # '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      # privateKeyFile = "path to private key file";
      privateKeyFile = "${config.services.onepassword-secrets.outputDir}/wg/private-key";
      # config.sops.secrets."protonvpn/hk-6".path;

      peers = [
        # List of allowed peers.
        { # Feel free to give a meaning full name
          # Public key of the peer (not a file path).
          # UDM
          publicKey = "5XI+XnWv3KFyu30T5gam9Sfy/tyCctnT+5B3fps+M1k=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.11.12.16/32" ];
        }
        # { # John Doe
        #   publicKey = "{john doe's public key}";
        #   allowedIPs = [ "10.11.12.3/32" ];
        # }
      ];
    };
  };
}
