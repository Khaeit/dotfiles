#ation file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "KTLN-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

# Tailscale
services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  services.desktopManager.plasma6.enable = true;
  
  # Configure keymap in X11
  #services.xserver.xkb = {
  #  layout = "us";
  #  variant = "";
  #};

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kait = {
    isNormalUser = true;
    description = "Kaitlyn";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
    ];
  };

  # Install firefox.
#  programs.firefox.enable = true;

  # Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  security.polkit.enable = true;
  
  programs.kdeconnect.enable = true;
#enable KDEConnect ports
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    vscode
    vscode-extensions.ms-dotnettools.csdevkit
    vscode-extensions.ms-dotnettools.csharp
    vscode-extensions.ms-dotnettools.vscode-dotnet-runtime
    powershell
    teams-for-linux
    obs-studio
    gimp
    inkscape
    krita
    ytdl-sub
    vlc
    youtube-music
    wineWowPackages.stable
#browsers
    librewolf
    brave
    filezilla
#system Utils
    nautilus
    keepassxc
    fastfetch  
    gparted
    htop
    imv
    superfile
    gammastep
    micro
    git
    cliphist
    light
    libnotify
    zsh
    cava
    cmus
    amberol
    sl
    pwvucontrol
    qbittorrent
#hyprland pkgs
    kitty
    waybar
    rofi
    hyprlock
    hyprpaper
    hyprutils
    hyprpolkitagent
    hyprcursor
    fprintd   
    wofi
    catppuccin-cursors.mochaMauve
    hyprwall
    hyprgui
    hyprsunset
    hyprlandPlugins.hy3
    brightnessctl
    swaynotificationcenter
    hypridle
  #screenshots
    grim
    slurp
    wl-clipboard
# Social / Gaming
    vesktop
    prismlauncher
  
#fonts
    nerdfonts
    comfortaa    

#virtualisation
    qemu
];
# Steam
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

#fingerprint settings
    services.fprintd.enable = true;
    services.fprintd.tod.enable = true;
    services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;
# Virtual Machine Manager
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["kait"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd.qemu.swtpm.enable = true;

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

}
