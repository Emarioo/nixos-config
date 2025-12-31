
This config does not provide wallpapers (github has file size limit)

![](/docs/img/nixos_screenshot.png)

# How to setup
On a NixOS machine make sure a basic configuration.nix and hardware-configuration.nix has been made.

You also need git to clone the repo.

The config assumes user "emarioo" and that
the repo is cloned at `/home/emarioo/nixos-config`.
The config assumes host name "lapis".

```bash
nix-shell -p git

cd ~
git clone git:github.com:Emarioo/nixos-config
cd nixos-config
./link_config.sh # symlink in /etc/nixos/configuration.nix -> /home/emarioo/nixos-config/hosts/lapis
sudo nixos-rebuild switch
reboot
```

# TODO
- [X] I cannot modify waybar, hyprland in real time without rebuilding configuration. I want two modes, one for normal usage with nixos reproducability and one where i can update waybar and other configs live. **UPDATE:** config.lib.file.mkOutOfStoreSymlink fixes it.
- [X] Move vscode settings into nixos config
- [x] Figure out how to store all configs on github. neovim keybinds, nixos config, hyprland config, kitty config. waybar xml/json? and so on.
- [ ] Where to store wallpapers? Keeping URL where i find it is not enough, it might disappear. Github has 10MB limit. Store on external SDD, VPS and other places?
      Time to finish unisync to backup them up in all places?
- [ ] Hyprland
    - [ ] Keybinds for moving and resizing panels. 
    - [x] Change cursor. **UPDATE::** Graphite cursors, at least better than default, changing cursor requires reboot or hyprland reload?
    - [ ] SUPER+M hyprland should shutdown computer, not logout.
- [ ] Neovim setup to replace VSCode
    - [ ] Relative numbers, space instead of tab
    - [ ] Plugins, file search, word/regex search in workspace files. 
    - [ ] Learn keybinds to replace: jump to start of file, HOME/END, PageUp/PageDown. 
    - [ ] Plugin to view markdown files (might use an application, not neovim plugin)
- [x] Prettify waybar. Some boxes are broken and useless? Battery life is useful.
- [ ] Waybar, add sound module. I want to know if sound is on or off "FN+F1". Might as well show sound volume too.
- [x] Animated wallpaper
- [ ] Login/logout screen. WIN+M logs me out but all apps are closed. It should systemctl suspend and then show login and then apps remain.
- [ ] Anime wallpaper per workspace?
- [ ] More gaming on Linux.
- [ ] NixOS on main PC.
- [ ] Find nice font for kitty, neovim.
- [ ] Animated Wallpaper on login/logout screen. **UPDATE:** Currently Frieren background, very nice, animated would be nice.
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
Wuthering waves, girl, flowers
https://wallhaven.cc/w/m (link lost?)

shorekeeper
https://moewalls.com/anime/shorekeeper-rainy-day-wuthering-waves-live-wallpaper/
