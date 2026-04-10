{ self, inputs, ... }:
{
  flake.nixosModules.andromedaConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.commonConfig
        # Add hardware-specific modules if needed
        # inputs.nixos-hardware.nixosModules.intel-4th-gen
      ];

      networking.hostName = "andromeda";

      # Headless operation (no GPU needed)
      boot.kernelParams = [
        "nomodeset"
        "console=tty0"
        "console=ttyS0,115200"
      ];

      # User configuration
      users.users.andromeda = {
        isNormalUser = true;
        description = "NAS Administrator";
        extraGroups = [
          "wheel"
          "users"
          "smbusers"
        ];
        openssh.authorizedKeys.keys = [
          # Add your SSH public key here
        ];
      };
    };
}
