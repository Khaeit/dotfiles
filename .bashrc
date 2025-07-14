#! /bin/bash
#display ascii art
 ./bash/ktlNet1.sh
 
 echo -e
 
#Aliases
  #Superfile
   alias spf="superfile"
  #Nixos
   alias nixedit="sudo micro /etc/nixos/configuration.nix"
   alias newgen="sudo nixos-rebuild switch"
  #Tailscale
   alias tsup="sudo tailscale up"
   alias tsdown="sudo tailscale down"
   alias tstat="tailscale status"
"
  #Ascii art shortcuts
   alias trnsflg="~/bash/transflag.sh && echo -e"
   
  #Window Managers
   #Hyprland stuff
	 alias hypredit="micro ~/.config/hypr/hyprland.conf"
	#Niri stuff
	 alias niriedit="micro ~/.config/niri/config.kdl"
	#Sway
	 alias swayedit="sudo micro /etc/sway/config"
	#Waybar
	 alias waycss="micro ~/.config/waybar/style.css"
	 alias wayedit="micro ~/.config/waybar/config.jsonc"

# prompt 
bold=$(tput bold)
normal=$(tput sgr0)
#PS1=COLOUR {time} COLOUR ARROW COLOUR  {username}  COLOUR ARROW COLOUR {bash version}  COLOUR ARROW COLOUR {directory} COLOUR ARROW COLOUR {$}  COLOUR ARROW COLOUR
PS1='\e[44m\e[30m${bold} \t \e[45m\e[34m\e[45m\e[30m \u \e[47m\e[35m\e[47m\e[30m \v \e[45m\e[37m\e[45m\e[30m \W \e[35m\e[44m\e[44m\e[30m \$ \[\033[1;0m\]\e[34m\e[0m${normal} '

. "$HOME/.cargo/env"
