# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sean/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall

# This will set the default prompt to the walters theme
prompt bigfade

# Vars used later on by Zsh
export EDITOR="nano"
export BROWSER=firefox
export XTERM="urxvt"
export PATH="${PATH}:${HOME}/bin"

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

alias ltmux="if tmux has; then tmux attach; else tmux new; fi"
alias update='yaourt -Syu --aur'
alias ls='ls --color=auto -F'
alias dir='ls -1'
alias orphans='sudo pacman -Rs $(pacman -Qtdq)'
alias r4="mplayer -really-quiet -playlist http://bbc.co.uk/radio/listen/live/r4.asx < /dev/null &"
alias r4x="mplayer -really-quiet -playlist http://www.bbc.co.uk/radio/listen/live/r4x.asx < dev/null &"
alias rte="mplayer -really-quiet -playlist http://dynamic.rte.ie/av/live/radio/radio1.asx < /dev/null &"
alias mc="mc -S /home/sean/.mc/brown.skin"
alias xp="VBoxManage startvm "XP""

alias -s avi=mplayer
alias -s cbr=mcomix
alias -s cbz=mcomix
