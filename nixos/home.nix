{pkgs, ...}: {
  home.packages = [
    pkgs.atool
    pkgs.httpie

    ## Fontes
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.inter
    pkgs.ubuntu_font_family
    pkgs.dejavu_fonts
    pkgs.fira-code
    pkgs.overpass
    pkgs.gnome-font-viewer # visualizador ne pae

    ## Rice
    pkgs.dunst
    pkgs.rofi
    pkgs.libnotify
    pkgs.nitrogen
    pkgs.pfetch
    pkgs.tty-clock

    ## Jogos y games
    pkgs.lutris
    pkgs.mangohud
    pkgs.goverlay

    ## Internet
    pkgs.telegram-desktop
    pkgs.brave
    pkgs.discord
    pkgs.freetube
    pkgs.webcord
    pkgs.qbittorrent

    ## Acessorios
    pkgs.mate.mate-tweak
    pkgs.xfce.ristretto
    pkgs.bc
    pkgs.kdePackages.kdialog
    pkgs.dialog
    pkgs.sassc
    pkgs.glib
    pkgs.ksnip
    pkgs.copyq
    pkgs.zenity
    pkgs.kitty
    pkgs.pnmixer
    pkgs.vscodium

    ## Mídia
    pkgs.gpu-screen-recorder-gtk
    pkgs.youtube-music
    pkgs.quodlibet

    ## Sys
    pkgs.intel-vaapi-driver
    pkgs.polkit_gnome
    
    ## Outros
    pkgs.nix-search-cli
    pkgs.networkmanagerapplet

  ];
  home.username = "deive";
  home.homeDirectory = "/home/deive";
  programs.home-manager.enable = true;

  programs.bash.enable = true;
  nixpkgs.config.allowUnfree = true;
  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.05";

  ## EU
  programs.git = {
    enable = true;
    userName = "HavanaHL";
    userEmail = "x";

    extraConfig.credential.helper = "store";
  };

  fonts.fontconfig.enable = true;
}
