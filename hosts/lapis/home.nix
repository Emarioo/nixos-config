{ config, pkgs, ... }:

{
    home.username = "emarioo";
    home.homeDirectory = "/home/emarioo";

    home.packages = with pkgs; [
        fd
        ripgrep
        tree
        home-manager
        btop
        audacity
        vlc
        neofetch
        krita
        blender
        prismlauncher
        spotify
        ncspot

        # Move elsewhere?
        valgrind
        tracy

    ];

    programs.tmux = {
        enable = true;
    };
    programs.bash.enable = true;

    let
        cfgDir = /home/emarioo/nixos-config/home/emarioo/waybar;
    in
        programs.waybar = {
            enable = true;
            configFile = cfgDir + "/config.jsonc";
            styleFile  = cfgDir + "/style.css";
        };

    home.file = {
        ".config/waybar/mullvad-click.sh".source = ~/nixos-config/home/waybar/mullvad-click.sh;
        ".config/waybar/mullvad-status.sh".source = ~/nixos-config/home/waybar/mullvad-status.sh;
    };

    home.sessionVariables = {
        GDK_CORE_DEVICE_EVENTS = "1";
    };
    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
    };

    programs.git = {
        enable = true;
    };

    programs.firefox.enable = true;
    programs.steam.enable = true;
    programs.obs-studio.enable = true;

    programs.neovim = {
        enable = true;
        defaultEditor = true;

        extraPackages = with pkgs; [
            # Useful dependencies
            ripgrep
            fd
            tree-sitter
        ];

        plugins = with pkgs.vimPlugins; [
            # Plugin manager
            plenary-nvim
            popup-nvim
            telescope-nvim
            nvim-treesitter.withAllGrammars
            markdown-preview-nvim
        ];  
    };
    # xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
    programs.home-manager.enable = true;
  
    home.stateVersion = "25.05";
}

