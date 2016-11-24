#                 ██      
#                ░██      
#  ██████  ██████░██      
# ░░░░██  ██░░░░ ░██████  
#    ██  ░░█████ ░██░░░██ 
#   ██    ░░░░░██░██  ░██ 
#  ██████ ██████ ░██  ░██ 
# ░░░░░░ ░░░░░░  ░░   ░░  
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ cirrus <cirrus@archlinux.info>
# ░▓ code   ▓ https://gist.github.com/cirrusUK
# ░▓ mirror ▓ http://cirrus.turtil.net
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
#█▓▒░ 

[[ $- = *i* ]] || return
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh 
export  BROWSER="${${DISPLAY+firefox}:-w3m}" 
#export  TERM="xterm-256color"
export  ABSROOT="$HOME/build" 
export  EDITOR="nano" 
export  HISTFILE=/home/cirrus/.logs/zhistory
export  HISTFILESIZE=10000
export  HISTSIZE=${HISTFILESIZE}
export  HISTIGNORE="&:[ ]*:exit:ls:bg:fg:cd:pacsyy:pacsu:history:clear"           
export  PAGER="less" 
export  SUDO_PROMPT="Password: " 
export  IPLAYER_OUTDIR="/mnt/INT2/video/pvr" 
export  MUTT_EDITOR="nano" 
export  MOZ_USE_OMTC=1 
export  LIBVA_DRIVER_NAME=vdpau
export  VDPAU_DRIVER=r600
export  SSH_KEY_PATH="~/.ssh/dsa_id" 
export  ARCHFLAGS="-arch x86_64"  
export  LANG="en_GB.UTF-8"               # ...as default language.
export  TZ="Europe/London"         # Force our time zone this location.
export VIRTUAL_ENV="/home/cirrus/venv"
export  CHEATCOLORS="true"
export SOCCER_CLI_API_TOKEN="0e479074171240a282136de60497dec9"
export SYSTEMD_LESS=FRXMK journalctl
#
# Set locale 
export LANG="en_GB.UTF-8" 
export LESSCHARSET="utf-8"
#
# ls colors 
export LS_COLORS="di=34"              # directories 
export LS_COLORS="${LS_COLORS}:fi=0"  # files 
export LS_COLORS="${LS_COLORS}:ln=35" # symlinks 
export LS_COLORS="${LS_COLORS}:pi=0"  # fifo file 
export LS_COLORS="${LS_COLORS}:so=32" # socket files 
export LS_COLORS="${LS_COLORS}:bd=33" # block devices 
export LS_COLORS="${LS_COLORS}:cd=33" # character devices 
export LS_COLORS="${LS_COLORS}:or=37" # orphaned symlinks 
export LS_COLORS="${LS_COLORS}:mi=37" # missing file (referenced to by symlink) 
export LS_COLORS="${LS_COLORS}:ex=31" # executable file 
#
# Set XDG directories 
export XDG_DATA_HOME="${HOME}/.local/share" 
export XDG_CONFIG_HOME="${HOME}/.config" 
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/" 
export XDG_CONFIG_DIRS="/etc/xdg/" 
export XDG_CACHE_HOME="${HOME}/.cache"
#
# fix for QT5 
export QT_STYLE_OVERRIDE=GTK+ 
#
# SLRN
export NNTPSERVER='freenews.netfront.net'
#
#toilet -f mono12 --gay --w 100 Arch
#alsi -c1=red -c2=blue -t red
#fortune | ponysay
#command cowsay -f tux $(fortune all)
cat /etc/motd
#toilet -f future --metal ' arch'
#cat ~/issue
echo  "\e[38;5;82mHello \e[38;5;198m$USER"
echo "Today is \e[31m$(date)\e[0;51m"
echo -e "\e[3mPresent working directory: \e[0;35m$(pwd)\e[0m"
echo "\e[0;44m \e[0;47m \e[0;46m "
source ~/.config/functions.zsh
source ~/.config/alias.zsh
source ~/.config/command-not-found.zsh
#Powerline & oh-my-zsh config.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerline"
source $ZSH/oh-my-zsh.sh
POWERLINE_FULL_CURRENT_PATH=true
COMPLETION_WAITING_DOTS=true
plugins=( git ant colorize)
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true
#
# Menu completion
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes
#
autoload -Uz colors \
             compinit \
             promptinit \
             edit-command-line \
             run-help \
             zmv

unsetopt prompt_cr prompt_sp     #remove the partial line: %
#
setopt autocd \
       complete_aliases \
       glob_dots \
       extended_history \
       hist_verify \
       hist_ignore_all_dups \
       hist_save_no_dups \
       hist_ignore_space \
       hist_reduce_blanks \
       inc_append_history \
       interactive_comments \
       numeric_glob_sort \
       no_bg_nice \
       print_exit_value \
       prompt_subst \
       notify
       

# jump around
. /home/cirrus/scripts/z/z.sh
#
#
#define path
PATH=$PATH:/usr/lib/cw:/home/cirrus/.gem/ruby/2.3.0/bin:/home/cirrus/.bin:/usr/lib/surfraw:/home/cirrus/venv/bin
export PATH="/usr/lib/cw:$PATH"
# needs to be at the bottom, or completion will break highlighting.
#source /home/cirrus/scripts/cc.zsh
source /home/cirrus/scripts/zsh-syntax-highlighting-filetypes.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh   
