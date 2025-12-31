{ config, pkgs, ... }:
{
    home.username = "emarioo";
    home.homeDirectory = "/home/emarioo";

    home.packages = with pkgs; [
        fd
        git
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

        waybar

        # Move elsewhere?
        valgrind
        tracy

    ];

    programs.tmux = {
        enable = true;
    };
    programs.bash.enable = true;

    home.file = {
        ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/waybar";
        ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/hypr";
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/nvim";
    };

    home.sessionVariables = {
        GDK_CORE_DEVICE_EVENTS = "1";
    };
    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
    };

    programs.firefox.enable = true;

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
  
    home.stateVersion = "25.05";
}

