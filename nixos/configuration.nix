# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  #  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  networking.hostName = "Genesis"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Maceio";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # WM
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.openbox.enable = true;

  # DE
  services.xserver.desktopManager.mate.enable = true;

  # DM
  services.xserver.displayManager.lightdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  ## keymap pra wayland
  # services.xserver.layout = "br";

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.deive = {
    isNormalUser = true;
    description = "deive";
    extraGroups = ["networkmanager" "wheel" "storage"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    
    ## Multimedia
    vlc
    audacious
    mpv
    yt-dlp
    ffmpeg

    ## Jogos y games
    steam

    ## Sys
    wget
    intel-vaapi-driver
    libvdpau-va-gl
    polkit
    gvfs
    ntfs3g
    exfat
    fuse
    intel-media-sdk
    
    ## Acessorios
    fastfetch
    peazip
    unrar
    htop
    btop
    tmux
    unzip
    nwg-look
    picom
    xfce.tumbler
    pkgs.gimp3
    pavucontrol
    wineWowPackages.stable
    nvtopPackages.intel
    playerctl
    git
    git-filter-repo
    xfce.mousepad
    xfce.thunar
    qt6ct
    xdg-user-dirs
    zsh
  
  ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  ### Minhas config nessa porra

  ## Zsh
# programs.zsh.enable = true;
  
  ## Polkit
  security.polkit.enable = true;


  ## Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Outros troço do flakes
  nix.nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) (lib.filterAttrs (_: value: lib.isType "flake" value) inputs);
  nix.settings.flake-registry = "";

  ## discos
  services = {
    #udisks2.enable = true;
    gvfs.enable = true;
  };

  ## Lix
  nix.package = pkgs.lixPackageSets.latest.lix;

  ## Zram
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "lz4";
  };

  ## Steam Configurasoes
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  ## Flatpak
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  ## Etc

  # Configuração específica para gpu fudida | Vaapi: 1
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  # Hardware e Gráficos | GPU & Vaapi: 1.1
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # i965 
      libvdpau-va-gl
    ];
  };

  # Variaveis de ambiente
  
  environment.sessionVariables = {
    
    ## Vaapi: 1.2
    LIBVA_DRIVER_NAME = "i965"; # i965 é mais estável para Bay Trail
    VDPAU_DRIVER = "va_gl"; # Melhor compatibilidade com VDPAU

    ## QT
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "gtk2";

    ## XDG USER DIRS
    XDG_DOCUMENTS_DIR = "$HOME/Documentos";
    XDG_DOWNLOAD_DIR = "$HOME/Downloads";
    XDG_MUSIC_DIR = "$HOME/Música";
    XDG_PICTURES_DIR = "$HOME/Imagens";
    XDG_VIDEOS_DIR = "$HOME/Vídeos";
  };

  # Parametros de Kernel
  boot.kernelParams = [
    "i915.enable_rc6=1" # Power management
    "i915.enable_psr=0" # Desativa PSR (pode causar problemas em Bay Trail)
  ];

  # Aliases

  environment.shellAliases = {
    YTM = "yt-dlp -x --audio-format mp3 --audio-quality 320k --embed-thumbnail --convert-thumbnails jpg --ppa \"EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop='min(iw,ih):min(iw,ih)'\"";
    YTMP = "yt-dlp -x --audio-format mp3 --audio-quality 320k --embed-thumbnail --convert-thumbnails jpg --ppa \"EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop='min(iw,ih):min(iw,ih)'\" --yes-playlist";
    nxs = "sudo nixos-rebuild switch --flake path:/etc/nixos#Genesis";
    hms = "home-manager switch --flake path:/etc/nixos#deive@Genesis";
    nxc = "nix-store --gc";
    fu = "sudo nix flake update --flake /etc/nixos";
  };
}
