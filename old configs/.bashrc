#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

alias ltmux="if tmux has; then tmux attach; else tmux new; fi"
alias update='yaourt -Syu --aur'
alias ls='ls --color=auto'
alias orphans='sudo pacman -Rs $(pacman -Qtdq)'
alias r4="mplayer -really-quiet -playlist http://bbc.co.uk/radio/listen/live/r4.asx < /dev/null &"
alias r4x="mplayer -really-quiet -playlist http://www.bbc.co.uk/radio/listen/live/r4x.asx < dev/null &"
alias rte="mplayer -really-quiet -playlist http://dynamic.rte.ie/av/live/radio/radio1.asx < /dev/null &"
alias mc="mc -S /home/sean/.mc/brown.skin"
alias xp="VBoxManage startvm "XP""

complete -cf sudo

export HISTCONTROL=ignoredups

clear
reset

export EDITOR=nano
export BROWSER=firefox

# As far as any apps (like chromium of which we open files from directly) needs to be concerned, we run LXDE
export DESKTOP_SESSION=LXDE


