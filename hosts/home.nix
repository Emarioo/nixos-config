{ config, pkgs, ... }:
let
  opts = import ./opts.nix {};
in
{
    home.username = opts.userName;
    home.homeDirectory = "/home/${opts.userName}";

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

    home.file = {
        ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${opts.repoPath}/home/waybar";
        ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${opts.repoPath}/home/hypr";
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${opts.repoPath}/home/nvim";
    };

    home.sessionVariables = {
        GDK_CORE_DEVICE_EVENTS = "1";
    };
    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
    };

    programs.tmux = {
        enable = true;
    };
    programs.bash = {
        enable = true;
        initExtra = ''
            export NIX2_CONFIG=${opts.repoPath}
            export NIX2_USER=${opts.userName}
            export NIX2_HOSTNAME=${opts.hostName}
        '';
    };

    home.sessionVariables = {
        NIX2_CONFIG=opts.repoPath;
    };

    xdg.configFile = {
        "Code/User/settings.json".source =
            config.lib.file.mkOutOfStoreSymlink
            "${opts.repoPath}/home/vscode/settings.json";

        "Code/User/keybindings.json".source =
            config.lib.file.mkOutOfStoreSymlink
            "${opts.repoPath}/home/vscode/keybindings.json";
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

