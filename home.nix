{ config, pkgs, ... }:

{
    home.username = "emarioo";
    home.homeDirectory = "/home/emarioo";

    home.packages = with pkgs; [
        fd
        ripgrep
        home-manager
    ];

    home.sessionVariables = {
        GDK_CORE_DEVICE_EVENTS = "1";
    };
    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
    };

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

