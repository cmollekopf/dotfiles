# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="miloshadzic"
#export ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git command_coloring history_substring_search kate ssh-agent zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# Customize to your needs...
unsetopt correct_all
unsetopt share_history
setopt extended_glob

bindkey -v
bindkey '^R' history-incremental-search-backward
zstyle ':completion:*:functions' ignored-patterns '_*'
# Fix cd .. completion
zstyle ':completion:*' special-dirs true

zstyle :omz:plugins:ssh-agent agent-forwarding on

# sourcing some random stuff

# Powerline
# source /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

#Unlike the distro shipped profile files, this doesn't break things (i.e. cmakekde)
source $HOME/.dotfiles/zsh/cdargs-zsh.sh

# export GREP_COLOR="1;33"
alias grep='grep --color=auto'
#alias ls='ls --ignore-backups'

#enable "mmv *.dat *.dat_old" or "mmv **/*2008.mp3 **/*2009.mp3" or "mmv *somestablestring* *somenewstablestring*"
autoload -U zmv
alias mmv='noglob zmv -W'

export LESS="-R"

export VISUAL=kwrite
export EDITOR=vim
#overrides the previous definitions
export GIT_EDITOR=vim

# Report CPU usage for commands running longer than 10 seconds
REPORTTIME=10

# Used in conjunction with findup and .my-setup to autoload .my-setup when entering the directory
# function cd() {
#   if test -z "$1"; then
#     builtin cd
#   elif test -z "$2"; then
#     builtin cd "$1"
#   else
#     builtin cd "$1" "$2"
#   fi
#   _f=`findup .my-setup`
#   if test -n "$_f" -a "$_lastf" != "$_f"; then
#     echo "Loading $_f"
#     _lastf="$_f"
#     source "$_f"
#   fi
# }

export OPERAPLUGINWRAPPER_PRIORITY=0
export OPERA_KEEP_BLOCKED_PLUGIN=1

alias nepomukcmd="sopranocmd --socket `kde4-config --path socket`nepomuk-socket --model main --nrl"
alias nepomukshutdown="qdbus org.kde.NepomukServer /nepomukserver org.kde.NepomukServer.quit"
alias imonline="qdbus org.kde.kded /modules/networkstatus org.kde.Solid.Networking.setNetworkStatus ntrack 4"
alias imoffline="qdbus org.kde.kded /modules/networkstatus org.kde.Solid.Networking.setNetworkStatus ntrack 1"
export INTEL_LICENSE_FILE=/opt/intel/licences/NCOM_L_VT__NHBB-X2FZ6DBD.lic
alias vtune="/opt/intel/vtune_amplifier_xe_2011/bin64/amplxe-gui"
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export AWT_TOOLKIT="MToolkit"

alias tmux="TERM=xterm-256color tmux"

export PATH="/usr/lib64/ccache/:$PATH:/home/chrigi/.gem/ruby/1.9.1/bin"
alias make='nice make -j5'

export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:/opt/devel/global
export CMAKE_INCLUDE_PATH=${CMAKE_INCLUDE_PATH}:/opt/devel/global/include
export KF5=$HOME/kf5
# make the debug output prettier
export KDE_COLOR_DEBUG=1
export QTEST_COLORED=1

alias importHistory='fc -RI'

alias clip='xclip -selection clipboard -i'

#eval $(ssh-agent)
alias sshlogin='ssh-add ~/.ssh/id_dsa'

alias android-connect="mtpfs -o allow_other /mnt/android"
alias android-disconnect="fusermount -u /mnt/android"

#fedora specific
alias yum='sudo yum'
alias vim='gvim -v' #no clipboard support in the vim package

#source devel environment which installs into /opt/devel
function srcdev() {
	source ~/devel/kde/.my-setup
    if [[ -n "$1" ]]; then
        setEnv $1
    fi
}

function srcAkonadiNext() {
    srcdev
    setKDEEnv kde
    export QT_PLUGIN_PATH=/opt/devel/kde/plugins
    cd ~/devel/kde/akonadinext
    # cd ~/devel/build/kde/kde/akonadinext
    # vim -c "cd ~/devel/kde/akonadinext/"
    # disown %1
}

# fd - cd to selected directory
function fd() {
    local dir
    dir=$(find ${1:-*} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

# cfg - cd to selected directory
function cdf() {
    fd ~/
}

# vim gdb
function vdb() {
    vim -c "ConqueGdb ${1:-*}"
}

# vim gitk
function gitv() {
    #https://stackoverflow.com/questions/22409816/vim-launch-command-after-load-plugins
    # vim -c "autocmd VimEnter * Extradite"
    vim -c "autocmd VimEnter * Gitv ${1:-*}"
}

function publish() {
    git push kolab $1:$1
    git push github $1:$1
}

function gdb-child() {
    gdb -ex "set follow-fork-mode child" -ex "run" $1
}

function gdb-run() {
    gdb -ex "set args \"${2:-*}\"" -ex "run" $1
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias arckolab='arc --conduit-uri=https://git.kolab.org/conduit/'

unset GREP_OPTIONS

alias dockercleancontainers='docker rm $(docker ps -a -q)'
alias dockerrmuntagged="docker rmi $(docker images | grep "^<none>" | awk '{print $3}' ORS=' ')"
# alias dockerrmuntagged="docker rmi `docker images -qf 'dangling=true'`"
alias startakonadi="systemd-cat -t "akonadi" akonadictl start"
alias akonadilog="journalctl -n99  -f SYSLOG_IDENTIFIER=akonadi"
alias devenv='~/docker/testenv.py'

export GOPATH=~/devel/go
setxkbmap -layout ch
xmodmap ~/.Xmodmap
