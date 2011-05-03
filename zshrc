##################################################################
## Notes
##
## Loop over command output with spaces in lines:
## for i (${(f)"$(some_command)"}) frobnicate $i

##################################################################
## Custom shortcuts

# environment variables
export EDITOR="vim"
export TERM=rxvt-256color
export DESKTOP="ginko"
export LAPTOP="jimmy"
export SERVER="linolium.mine.nu"
export PATH="/home/linolium/bin:$PATH"
export PATH="/home/linolium/sync/bin:$PATH"
export PATH="/usr/bin/perlbin/vendor/:$PATH"
export PATH="/opt/mathematica/bin:$PATH"
export PATH="/opt/squeak/bin:$PATH"
export PATH="/opt/android-sdk/tools:$PATH"
export PATH="/opt/android-sdk/platform-tools:$PATH"

# listing aliases
alias ls='ls --color=auto'
alias u="ls"
alias uu="ls -alh"
alias grep="grep --color"

# standard aliases
alias root="sudo su -"
alias reboot="sudo shutdown -r now"
alias poweroff="sudo shutdown -h now"
alias flog="sudo tail -f /var/log/messages.log"
alias sync="unison -logfile ~/.unison.log"
alias synergy="killall synergyc 2>/dev/null; nohup synergyc -1 ginko >/dev/null 2>/dev/null"
alias vnc="rx11vnc -fs -l linolium $DESKTOP"
alias kb="setxkbmap -rules xorg -model logic -layout 'us,th' -option 'grp:alt_shift_toggle'; xmodmap ~/.xmodmap; xset r rate 220 27"
alias binupdate="compgen -c > /tmp/linolium-dmenu"
alias preview="feh -F -Z -d"
alias umount="fusermount -u"
alias pacman="pacman-color"
alias yaourt="yaourt --noconfirm"
alias mplayer="mplayer -softvol -softvol-max 1000"
alias cdmv="renamealbum --dest /mnt/storage/incoming/albums"
alias usblp="sudo modprobe usblp && sleep 3 && sudo rmmod usblp"

# quick folders
alias 221="cd ~/school/cs221ta"
alias 322="cd ~/school/cs322"
alias 411="cd ~/school/cs411"
export cs221="/home/linolium/school/cs221ta"
export cs322="/home/linolium/school/cs322"
export cs411="/home/linolium/school/cs411"
export math="/home/linolium/school/math342"
export chin="/home/linolium/school/chinese"
export coop="/home/linolium/school/co-op"
export tasktop="/home/linolium/work/tasktop"
export pa="/home/linolium/work/websites/Peace Arch Soccer"
export paw="/home/linolium/work/websites/Peace Arch Soccer/pasoccer"
export ish="/home/linolium/work/websites/Ishtar"
export in="/mnt/storage/incoming"

# ssh aliases
alias galiano="ssh m1n6@galiano.ugrad.cs.ubc.ca"
alias lulu="ssh m1n6@lulu.ugrad.cs.ubc.ca"
alias server="ssh -p443 linolium@$SERVER"
alias ginko="ssh linolium@$DESKTOP"
alias jimmy="ssh linolium@$LAPTOP"
#alias ftpproxy="sudo ssh -D 21 jkweb.ca"

# bind (F1, F2, F3) to ssh (server, desktop, laptop)
bindkey -s '\e[11~' 'server\n'
bindkey -s '\e[12~' 'ginko\n'
bindkey -s '\e[13~' 'jimmy\n'

# where can we find printed PDFs?
export PDF="/var/spool/cups-pdf/linolium/"

# our Windows compatibility aliases
#alias word="/opt/cxoffice/bin/wine --cx-app winword.exe"
#alias excel="/opt/cxoffice/bin/wine --cx-app excel.exe"
#alias powerpoint="/opt/cxoffice/bin/wine --cx-app powerpnt.exe"
#alias photoshop="/opt/cxoffice/bin/wine --cx-app photoshop.exe"

##################################################################
## Options for zsh

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
eval `dircolors -b`

# enable command completion
autoload -U compinit promptinit
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt cdablevars
setopt interactivecomments
setopt nobanghist
setopt noclobber
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt SH_WORD_SPLIT
setopt nohup
compinit
promptinit

# custom prompt
#prompt fire
PROMPT="$(print '%{\e[0;31m%}.:%{\e[1;30m%}%B[%m:%{\e[1;34m%}%~%{\e[1;30m%}]%b%{\e[0;31m%}:.%{\e[0m%}') "
RPROMPT="$(print '%{\e[1;30m%}%B[%{\e[1;34m%}%*%{\e[1;30m%}]%b%{\e[0m%}')"


# system environment variables
export EDITOR="vim"
export BROWSER="firefox"

# get special keys working
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
bindkey '^R' history-incremental-search-backward

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd
