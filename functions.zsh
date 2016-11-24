#      __                  _   _
#     / _|_   _ _ __   ___| |_(_) ___  _ __  ___
#    | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
#    |  _| |_| | | | | (__| |_| | (_) | | | \__ \
#    |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ cirrus <cirrus@archlinux.info>
# ░▓ code   ▓ https://gist.github.com/cirrusUK
# ░▓ mirror ▓ http://cirrus.turtil.net
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░

## WIKIPEDIA SEARCH FUNCTION ##
wikipediaSearch() {
echo -n -e "\n============================================\n\tWelcome to WikiPedia Search"; echo ""; i=1 ; for line in $(lynx --dump "http://en.wikipedia.org/w/index.php?title=Special%3ASearch&profile=default&search=$1&fulltext=Search" | grep http://en.wikipedia.org/wiki | cut -c7-); do echo $i $line; lines[$i]=$line ;  i=$(($i+1)); done ; echo -n -e "\n============================================\n\tPlease select the link to open - "; read answer; w3m ${lines[$answer]}
}

## ARCHWIKI SEARCH FUNCTION ##
archSearch() {
echo -n -e "\n============================================\n\tWelcome to Arch Wiki Search"; echo ""; i=1 ; for line in $(lynx --dump "https://wiki.archlinux.org/index.php?title=Special%3ASearch&profile=default&search=$1" | grep https://wiki.archlinux.org/ | cut -c7-); do echo $i $line; lines[$i]=$line ; i=$(($i+1)); done ; echo -n -e "\n============================================\n\tPlease select the link to open - "; read answer; w3m ${lines[$answer]}
}

# download the aur(4) package to the current directory, similar to cower -d from the old AUR, but using the officially supported method; git.
# usage:
# $ aurd <package-name>
aurd() {
    git clone https://aur4.archlinux.org/$1.git/
    #git clone ssh://aur@aur4.archlinux.org/$1.git/
}

# download the aur(4) package to the current directory, cd, build (clean) and prompt to install.
aurb() {
    git clone https://aur4.archlinux.org/$1.git/ && cd $1 && makepkg -sci
    #git clone ssh://aur@aur4.archlinux.org/$1.git/ && cd $1 && makepkg -sci
}

# update the package in the current directory
auru() {
    git pull && rm -f *.pkg.tar.xz || true && makepkg -sci
}

# Automatically do an ls after each cd
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls --group-directories-first --color=auto
  else
    builtin cd ~ && ls --group-directories-first --color=auto
  fi
}

aurctl(){
          curl -s https://aur.archlinux.org/packages/"${1:0:2}/$1/$1".tar.gz | tar xz
      }

#pb pastebin || Usage: 'command | pb or  pb filename'
pb () {
  curl -F "c=@${1:--}" https://ptpb.pw/
}

pbs () {
  gm import -window ${1:-root} /tmp/$$.png
  pbx /tmp/$$.png
}

pbx () {
  curl -sF "c=@${1:--}" -w "%{redirect_url}" 'https://ptpb.pw/?r=1' -o /dev/stderr | xsel -l /dev/null -b
}

## EXTRACT FUNCTION ## | Usage: extract <file>
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

#list servicesd
listd() {
	echo -e ${BLD}${RED}" --> SYSTEM LEVEL <--"${NRM}
	find /etc/systemd/system -mindepth 1 -type d | sed '/getty.target/d' | xargs ls -gG --color
	[[ $(find $HOME/.config/systemd/user -mindepth 1 -type d | wc -l) -eq 0 ]] ||
		(echo -e ${BLD}${RED}" --> USER LEVEL <--"${NRM} ; \
		find $HOME/.config/systemd/user -mindepth 1 -type d | xargs ls -gG --color)
}

#cd to dir of defined file | Usage: cdf <file>
cdf () {
  cd "$(dirname "$(locate -i "$*" | head -n 1)")" ;
}

#wego weather function## | usage wttr `city`
wttr () {
curl http://wttr.in/$1
}

#web search tool | Usage: gsearch <value>
function gsearch {
Q="$@";
GOOG_URL='https://www.google.co.uk/search?tbs=li:1&q=';
AGENT="Mozilla/4.0";
stream=$(curl -A "$AGENT" -skLm 50 "${GOOG_URL}${Q//\ /+}" | grep -oP '\/url\?q=.+?&amp' | sed 's|/url?q=||; s|&amp||');
echo -e "${stream//\%/\x}";
}

#search vodlocker for videos | Usage: vodlocker <foo>
vodlocker() {
gsearch site:vodlocker.com "$1" >> /mnt/INT2/video/medialink/mpv/"$1".m3u && mpv --playlist /mnt/INT2/video/medialink/mpv/"$1".m3u
}

#Convert to .mp4 | Usage: ipod5g foo.mpg
ipod5g () {
HandBrakeCLI -i "$1" -o "${1%.*}.ipod5g.mp4" --preset="iPod"
}

#List Realtime Soccer Results | Usage: score
#score() {
# watch -n10 --no-title "w3m http://www.livescores.com/ |awk '/live [0-9H]+[^ ]/,/red cards/'" ;
#}

#List Realtime Soccer Results from the SPL| Usage: spl
#spl() {
 #watch -n10 --no-title "w3m http://www.livescores.com/soccer/scotland/premier-league/ | awk '/live [0-9H]+[^ ]/,/Team/' | sed -n '1,25p'"
#}

##List Realtime Soccer Results from the EPL| Usage: epl
#epl() {
# watch -n10 --no-title "w3m http://www.livescores.com/soccer/england/premier-league/ | awk '/live [0-9H]+[^ ]/,/Team/' | sed -n '1,41p'"
#}

#Is server up ? | Usage: down4me <www.foo.com>
down4me() {
curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g';
}

#Sprunge Paste | Usage: sprunge <file>
function sprunge() {
  if (($#)); then
if [[ -f $1 && -r $1 ]]; then
curl -F 'sprunge=<-' http://sprunge.us < "$1"
    else
printf 'file %s does not exist or is not readable\n' "$1" >&2
      return 1
    fi
else
curl -F 'sprunge=<-' http://sprunge.us
  fi
}

# Compile and execute a C source on the fly
csource() {
	[[ $1 ]]    || { echo "Missing operand" >&2; return 1; }
	[[ -r $1 ]] || { printf "File %s does not exist or is not readable\n" "$1" >&2; return 1; }
	local output_path=${TMPDIR:-/tmp}/${1##*/};
	gcc "$1" -o "$output_path" && "$output_path";
	rm "$output_path";
	return 0;
}


## DICTIONARY FUNCTIONS ##
dwordnet () { curl dict://dict.org/d:${1}:wn; }
dacron () { curl dict://dict.org/d:${1}:vera; }
djargon () { curl dict://dict.org/d:${1}:jargon; }
dfoldoc () { curl dict://dict.org/d:${1}:foldoc; }
dthesaurus () { curl dict://dict.org/d:${1}:moby-thes; }

#internetinfo | Usage: ii
function ii()   # get current host related info
{
    echo -e "\n${RED}Kernel Information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    echo -e "\n${RED}Disk Usage :$NC " ; df -Th
    echo -e "\n${RED}LAN Information :$NC" ; netinfoLAN
    echo
}

#netinfo - shows LAN network information for your system (part of ii)
function netinfoLAN (){
echo "---------------------------------------------------"
/sbin/ifconfig enp4s0 | awk /'inet/ {print $2}'
/sbin/ifconfig enp4s0 | awk /'bcast/ {print $3}'
/sbin/ifconfig enp4s0 | awk /'inet6 addr/ {print $1,$2,$3}'
/sbin/ifconfig enp4s0 | awk /'HWaddr/ {print $4,$5}'
echo "---------------------------------------------------"
}

#Transfer/share any file 5GB limit | Usage: transfer ~/foo/bar
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }; alias transfer=transfer

# copy | Usage: copy /source/file /destination/file
copy() {
    size=$(stat -c%s $1)
    dd if=$1 &> /dev/null | pv -petrb -s $size | dd of=$2
}

# Run a command x times | Usage: runx <value>
# http://www.stefanoforenza.com/how-to-repeat-a-shell-command-n-times/
runx() {
    n=$1
    shift
    while [ $(( n -= 1 )) -ge 0 ]
    do
        "$@"
    done
}

# mkdir & cd into it | Usage: mkcd
mkcd() {
  if [ ! -n "$1" ]; then
    echo "Enter a name for this folder"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

#Search files & directories | Usage: search <file/dirs>
search() {
find . -iname "*$@*" | less;
}

#Grep process | Usage: psgrep <process>
psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto;
}

# Google images search bash function  | Usage: images <foo>
images() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "http://www.google.co.uk/search?tbm=isch&hl=en&source=hp&biw=1366&bih=679&q=$search"
}

# YouTube search bash function  | Usage: videos <foo>
videos() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "http://www.youtube.com/results?search_query=$search"
}

# DuckDuckGo search bash function  | Usage: ddg <foo>
ddg() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "http://duckduckgo.com/?q=$search"
}

# Wikipedia English search bash function   | Usage: wiki <foo>
wiki() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "http://en.wikipedia.org/w/index.php?search=$search"
}

# Android Play Store search bash function | Usage: android <foo>
android() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "http://play.google.com/store/search?q=$search"
}

# Soundcloud music bash search function  | Usage: soundcloud <foo>
soundcloud() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "https://soundcloud.com/search?q=$search"
}

# StackOverflow bash search function  | Usage: so <foo>
so() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    w3m "http://stackoverflow.com/search?q=$search"
}

# Pleer music bash search function  | Usage: pleer <foo>
pleer() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "https://pleer.com/search?q=$search"
}

# Amazon UK search bash function  | Usage: amazon <foo>
amazon() {
    search=""
    for term in $*; do
        search="$search%20$term"
    done
    xdg-open "http://www.amazon.co.uk/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=$search&x=0&y=0"
}

# Dictionary | Usage define <foo>
define() {
    curl -s dict://dict.org/d:$1 | grep -v '^[0-9]'
}

# set volume
vol ()
{
    pactl set-sink-volume 5 $1% ;
}

#encrypt <file> | Usage encrypt <file>
function encrypt() {
        [ -e "$1" ] || return 1
        openssl des3 -salt -in "$1" -out "$1.$CRYPT_EXT"
        [ -e "$1.$CRYPT_EXT" ] && shred -u "$1"
}

#decrypt <file.> | Usage decrypt <file.>
function decrypt() {
        [ -e "$1" ] || return 1
        [ "${1%.$CRYPT_EXT}" != "$1" ] || return 2
        openssl des3 -d -salt -in $1 -out ${1%.$CRYPT_EXT}
        [ -e "${1%.$CRYPT_EXT}" ] && rm -f "$1"
}

#wallpaper changer
fehpap() {
        zenity --file-selection | xargs feh --bg-scale
 }

unspacer() #remove spaces from files in current dir
{          #replaces spaces with underscores
 for i in *
  do
   [ ! "$i" == "$(echo $i | tr '\ ' '_')" && mv ./"$i" ./$(echo $i | tr '\ ' '_')
  done
}

# send link to podbeuter queue | usage podbeuter <podcasturl>
podqueue() {
           echo "$1 \"$HOME/Downloads/$(echo "$1" | awk -F'/' '{ print $NF }')\"" >> ~/.newsbeuter/queue ;
}

myt() {
        mpv ytdl://ytsearch10:"$1"
}

#youtube-dl full 1080p video/audio | Usage ytdlhd <url>
ytdlhd() {
    youtube-dl "$1" -f 137+140
}

#rtmp sniffing
sniff-start() {
               sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT ;
}

sniff-capture() {
                         rtmpsrv ;
}

sniff-end() {
             sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT ;
}

cmdfu() { curl "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
	| sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ;
}

 #Show used mirrors {archlinux}
mymirrors() {
            grep -v '^$\|^#' /etc/pacman.d/mirrorlist | awk '{print $3}' | awk -F '/' '{print $3}';
}

#URL Shortener  | Usage : short <url>
short() {
  curl -F"shorten=$*" https://0x0.st
}

#URL Shortener  | Usage : shorten <url>
shorten() {
	pbpst -s $1
}

#Upload-file | Usage : share /path/to/file.foo
share() {
  curl -F"file=@$*" https://0x0.st
}

uppb() {
curl -F c=@- https://ptpb.pw  < $1
}

ytconvert() {
        ffmpeg -i "$1" -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a copy "$2.mkv"
}

stopwatch(){
    date1=`date +%s`;
    while true; do
    days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
    done
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

#Fill screen with colours | Usage: colours
colours()
{
  _I=1
  _J=0
  _K=0
  _WIDTH=$COLUMNS
  _MARGIN=0
  while true; do
  _A=$(($RANDOM % 3))
  _B=$(($RANDOM % 2))
  _C=$(($RANDOM % 3))
  case $_A in
  0)
    case $_B in
    0)
      [ $_I -gt 1 ] && _I=$(($_I - 1))
    ;;
    1)
      [ $_I -lt 6 ] && _I=$(($_I + 1))
    ;;
    esac
  ;;
  1)
    case $_B in
    0)
      [ $_J -gt 0 ] && _J=$(($_J - 1))
    ;;
    1)
      [ $_J -lt 5 ] && _J=$(($_J + 1))
    ;;
    esac
  ;;
  2)
    case $_B in
    0)
      [ $_K -gt 0 ] && _K=$(($_K - 1))
    ;;
    1)
      [ $_K -lt 5 ] && _K=$(($_K + 1))
    ;;
    esac
  ;;
  esac
  case $1 in
    1)
      _DELTA=$2
      case $_C in
        0)
          [ $_WIDTH -lt $(($COLUMNS - 2*$_DELTA)) ] && _WIDTH=$(($_WIDTH + 2*$_DELTA))
        ;;
        1)
          [ $_WIDTH -gt $((1 + 2*$_DELTA)) ] && _WIDTH=$(($_WIDTH - 2*$_DELTA))
        ;;
      esac
      _MARGIN=$((($COLUMNS-$_WIDTH)/2))
    ;;
    2)
      _WIDTH=$2
      _DELTA=$3
      case $_C in
        0)
          [ $_MARGIN -le $(($COLUMNS - $_WIDTH - $_DELTA)) ] && _MARGIN=$(($_MARGIN + $_DELTA))
        ;;
        1)
          [ $_MARGIN -ge $_DELTA ] && _MARGIN=$(($_MARGIN - $_DELTA))
        ;;
      esac
    ;;
    *)
      _WIDTH=$COLUMNS
      _MARGIN=0
    ;;
  esac
  _NUMBER=$((15 + $_I + 6*$_J + 36*$_K))

  echo -en "\e[0;49m"
  if [ $_MARGIN -gt 0 ]; then
    for _FOO in $(seq $_MARGIN); do
      echo -en " "
    done
  fi

  printf "\e[0;48;5;${_NUMBER}m"
  for _FOO in $(seq $_WIDTH); do
    echo -en " "
  done

  echo -e "\e[0;49m"
  done
}

ipinfo() {
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
	curl ipinfo.io/"$1"
    else
	ipawk=($(hostname "$1" | awk '/address/ { print $NF }'))
	curl ipinfo.io/${ipawk[1]}
    fi
    echo
}

#simple note taker : Usage note
note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        printf "%s" > "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

