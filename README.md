My NixOS config which I dual boot along with Windows on my laptop and desktop computer.

![](/docs/img/nixos_screenshot.png)

# How to setup
**NOTE:** Setup will probably not be flawless, you may need to tweak something. When I have time I will do more testing in fresh environments.

On a NixOS machine make sure a basic configuration.nix and hardware-configuration.nix has been made.

Then run these in your home directory or wherever you want the local nixos config:

```bash
# if you don't have git
nix-shell -p git

# Clone repo
git clone git:github.com:Emarioo/nixos-config
cd nixos-config

# download wallpapers github.com/Emarioo/nixos-config/Releases to ./wallpapers
./fetch_wallpapers.sh

# create symlink from /etc/nixos/configuration.nix -> /home/$USER/nixos-config/hosts/lapis/configuration.nix
./link_config.sh lapis  # lapis refers to ./hosts/lapis/configuration.nix

# Before building NixOS configuration set user and host name.
# These are the defaults.
export NIX2_USER=emarioo
export NIX2_HOSTNAME=lapis

sudo nixos-rebuild switch
reboot
```

# TODO
- [X] I cannot modify waybar, hyprland in real time without rebuilding configuration. I want two modes, one for normal usage with nixos reproducability and one where i can update waybar and other configs live. **UPDATE:** config.lib.file.mkOutOfStoreSymlink fixes it.
- [X] Move vscode settings into nixos config
- [x] Figure out how to store all configs on github. neovim keybinds, nixos config, hyprland config, kitty config. waybar xml/json? and so on.
- [x] Login screen has animated frieren, but the login panel covers 30% of it. It should be smaller.
- [x] Remove hardcoded paths for wallpapers.
- [ ] Add flameshot config (save to ~/screenshots and don't prompt where to save)
- [x] Where to store wallpapers? Keeping URL where i find it is not enough, it might disappear. Github has 10MB limit. Store on external SDD, VPS and other places?
      Time to finish unisync to backup them up in all places? **UPDATE:** Store in github releases in wallpapers.tar.gz
- [ ] Hyprland
    - [ ] Keybinds for moving and resizing panels. 
    - [x] Change cursor. **UPDATE::** Graphite cursors, at least better than default, changing cursor requires reboot or hyprland reload?
- [ ] Neovim setup to replace VSCode
    - [ ] Relative numbers, space instead of tab
    - [ ] Plugins, file search, word/regex search in workspace files. 
    - [ ] Learn keybinds to replace: jump to start of file, HOME/END, PageUp/PageDown. 
    - [ ] Plugin to view markdown files (might use an application, not neovim plugin)
- [x] Prettify waybar. Some boxes are broken and useless? Battery life is useful.
- [ ] Waybar, add sound module. I want to know if sound is on or off "FN+F1". Might as well show sound volume too.
- [x] Animated wallpaper
- [x] Login/logout screen. WIN+M logs me out but all apps are closed. It should systemctl suspend and then show login and then apps remain. **UPDATE:** hyprlock takes screenshot and displays it when locked, very nice.
- [ ] Login screen freezes after some time (1 minute or so). You have to switch to terminal tty and restart display-manager. RAM is below 3GB, CPU seems fine.
- [ ] Anime wallpaper per workspace?
- [ ] More gaming on Linux.
- [ ] NixOS on main PC.
- [ ] Find nice font for kitty, neovim.
- [x] Animated Wallpaper on login/logout screen. **UPDATE:** Currently Frieren background, very nice, animated would be nice.
- [ ] Figure out a way to automatically restore panels on reboot. Vscode, firefox, terminals. firefox restores tabs at least.
- [ ] Cloud solution for collaborative document writing/reading (replacement for obsidian, dropbox). Unless dropbox works on Linux but ewww, dropbox nah.
- [x] Disable blur in kitty/hyprland for terminals.
- [ ] NixOS delete old builds automatically. GRUB is spammed with nixos configs which is unnecessary.
- [x] Notifications like "Connected to WIFI" dont disappear unless i click on it. Its a nuisance.
- [x] Auto connect bluetooth device. Same behaviour as when restoring panels after reboot.
- [x] Move nvim config and other configs to nixos home manager.


# How to
## Network/WIFI
This is how to connect to a WIFI network, editing and deleting you can figure out yourself.
```bash
# list networks
nmcli device wifi list
# connect
nmcli --ask device wifi connect "NETWORK_SSID"
```

The above requires this in NixOS config
```nix
networking.networkmanager.enable = true;
```

**NOTE:** You can use nmtui too. It's more user friendly but harder to copy network SSID?

## Nvidia
https://nixos.wiki/wiki/NVIDIA

Monitor temps
```bash
watch -n 1 nvidia-smi
```

## Bluetooth
https://nixos.wiki/wiki/Bluetooth
```bash
$ bluetoothctl
[bluetooth] # power on
[bluetooth] # agent on
[bluetooth] # default-agent
[bluetooth] # scan on
...put device in pairing mode and wait [hex-address] to appear here...
[bluetooth] # pair [hex-address]
[bluetooth] # connect [hex-address]

Bluetooth devices automatically connect with bluetoothctl as well:

$ bluetoothctl
[bluetooth] # trust [hex-address]
```

# Wallpapers

shorekeeper, used for desktop wallpaper
https://moewalls.com/anime/shorekeeper-rainy-day-wuthering-waves-live-wallpaper/

frieren water, used for login screen
https://moewalls.com/anime/frieren-amidst-water-lilies-beyond-journeys-end-live-wallpaper/

shorekeeper (with flowers, not animated), was used for desktop wallpaper
https://wallhaven.cc/w/mlqy18

frieren chilling on the floor, was used for login screen
https://wallhaven.cc/w/9depzk
