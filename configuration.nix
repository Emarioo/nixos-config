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

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.emarioo = import ./home.nix;
  users.users.emarioo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lapis"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  security.polkit.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    #font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  /**/
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  # environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Keypad delete key doesn't work in VSCode.fhs with this line. Something with Electron bugs with keys when using Wayland. Maybe it doesn't help that i use sv-latin1 keyboard layout?
  hardware.nvidia.prime = {
    offload.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:6:0:0";
  };
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  /**/
  nixpkgs.config.allowUnfree = true;

  services.xserver.enable = true;
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

  # Configure keymap in X11
  services.xserver.xkb = {
     layout = "se";
     variant = "";
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad.tapping = false;
    touchpad.disableWhileTyping = false;
    mouse.disableWhileTyping = false;
  };
  # services.xserver.autoRepeatInterval = 100;
  # services.xserver.autoRepeatDelay = 250;

  programs.firefox.enable = true;
  programs.steam.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # essentials
    vim
    pkg-config
    wget
    unzip
    git
    tmux
    vlc
    audacity
    mpv
    mesa
    libGL
    xorg.libX11
    
    # personal favorites
    neofetch
    krita   # drawing program
    blender # 3d modelling
    parted
    ntfs3g
    prismlauncher
    # vscode in home.nix
    valgrind
    tracy
    btop
    spotify
    ncspot
    ( catppuccin-sddm.override {
    flavor = "mocha";
    font  = "Noto Sans";
    fontSize = "9";
    background = "${/home/emarioo/wallpapers/wallhaven-9depzk_1920x1080.png}";
    loginBackground = true;
    })
    #sddm-astronaut
    kdePackages.sddm # dependecnies too sddm-astronaut
    #kdePackages.qtbase
    #kdePackages.qtsvg
    #kdePackages.qtvirtualkeyboard
    #kdePackages.qtmultimedia

    # themes, fonts, cursors
    graphite-cursors

    # programming tools
    gcc13
    gdb
    python311   
    cmake
    gnumake
    qemu
 
    # desktop, hyprland utilities
    kitty  # terminal
    waybar # status bar
    wofi   # app launcher
    mako   # notifications
    wl-clipboard
    polkit
    networkmanagerapplet
    swww
    mpvpaper
    kdePackages.dolphin    
    swaylock
    mullvad
    mullvad-vpn

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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

