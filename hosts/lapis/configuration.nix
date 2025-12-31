# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.emarioo = import ./home.nix;
  };

  users.users.emarioo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lapis"; # Define your hostname.
  networking.networkmanager.enable = true;
  security.polkit.enable = true;
  
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    #font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  nixpkgs.config.allowUnfree = true;

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
  }

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = {
     layout = "se";
     variant = "";
  };
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      #sddm-astronaut
      #kdePackages.qtbase
      #kdePackages.qtmultimedia
      #kdePackages.qtsvg
      #kdePackages.qtvirtualkeyboard
    ];
    theme = "catppuccin-mocha";
    #theme = "sddm-astronaut-theme";
    /*settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };*/
  };
  # environment.sessionVariables.QT_QML_IMPORT_PATH = "${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml";
  # TODO: Remove autologin
  # services.displayManager.autoLogin.enable = true;
  #services.displayManager.autoLogin.user = "emarioo";

  # Enable sound.
  #services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad.tapping = false;
    touchpad.disableWhileTyping = false;
    mouse.disableWhileTyping = false;
  };

  environment.systemPackages = with pkgs; [
    # essentials
    vim
    pkg-config
    wget
    unzip
    mpv
    ntfs3g
    parted

    mesa
    libGL
    xorg.libX11
    
    # personal favorites
    
    # vscode in home.nix
    
    ( catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${~/wallpapers/wallhaven-9depzk_1920x1080.png}";
      loginBackground = true;
    })
    #sddm-astronaut
    kdePackages.sddm # dependecnies too sddm-astronaut
    #kdePackages.qtbase
    #kdePackages.qtsvg
    #kdePackages.qtvirtualkeyboard
    #kdePackages.qtmultimedia

    # @NOCHECKIN does services.mullvad-vpn.enable add these programs?
    # mullvad
    # mullvad-vpn

    # programming tools
    gcc13
    gdb
    python311   
    cmake
    gnumake
    qemu
 
    # desktop, hyprland utilities
    kitty  # terminal
    wofi   # app launcher
    mako   # notifications
    wl-clipboard
    polkit
    networkmanagerapplet
    swww
    mpvpaper
    kdePackages.dolphin    
    swaylock
    graphite-cursors

    # laptop stuff
    brightnessctl
    playerctl
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    # xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services.mullvad-vpn.enable = true;

  systemd.user.services.lock-before-sleep = {
    description = "Lock screen before suspend";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.swaylock}/bin/swaylock";
    };
  };

  system.stateVersion = "25.05";
}

