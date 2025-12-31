
{ config, lib, pkgs, ... }:
{
  imports = [
    ../base.nix
  ];

  networking.hostName = "lapis"; # Define your hostname.
  
  # environment.systemPackages = base.environment.systemPackages ++ [ discord ];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    # environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Keypad delete key doesn't work in VSCode.fhs with this line. Something with Electron bugs with keys when using Wayland. Maybe it doesn't help that i use sv-latin1 keyboard layout?
    prime = {
      offload.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:6:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}

