#!/usr/bin/env bash

# $HOME/.bash_profle


for file in ~/.{alias,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# ENV. VARS

export MAVEN="/Library/Java/Apache/apache-maven-3.3.9/bin/"
export JDK8="/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home/"
export JAVA_HOME="$JDK8"
export TERM=xterm-256color
export CLICOLOR=1
export EDITOR=vim
export VISUAL=vim
export PS1="\[\033[1;34m\]\h:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ " 
PATH="/usr/local/bin:/usr/local/sbin:~/.local/bin:/opt/local/bin:/opt/local/sbin:$MAVEN:$PATH"
export PATH
export GPG_TTY=$(tty)
export MYVIMRC="$HOME/.vim/.vimrc"
export VIMINIT="source $MYVIMRC"
export PGPASSFILE="$HOME/.psql/.pgpass"
export TMUXCONF="$HOME/.tmux/.tmux.conf"

# ALIASES

alias sudo='sudo '                                      # enable aliases to be sudo’ed
alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias rm="rm -v"
alias ll="ls -FGlAht"                                   # list with details
alias cpd="cp -R"                                       # copy directory tree
alias rmd="rm -R"                                       # rm directory tree
alias path="echo -e ${PATH} \
| tr ':' '\n'"                                          # echo $PATH pretty
alias grep="grep -i --color"                            # colorized grep match
alias py2=python2.7
alias py3=python3.5
alias tmux_dt="tmux detach"
alias tmux_ls="tmux list-sessions"
alias config="/usr/bin/git \
--git-dir=$HOME/.files/ \
--work-tree=$HOME"                                      # git repository for .files
alias redis_start="sudo redis-server \
/opt/local/etc/redis.conf &"
alias pg95_start="sudo /opt/local/etc/
LaunchDaemons/org.macports.postgresql95-server/\
postgresql95-server.wrapper start"
alias pg95_stop="sudo  /opt/local/etc/
LaunchDaemons/org.macports.postgresql95-server/\
postgresql95-server.wrapper stop"
alias pg96_start="sudo /opt/local/etc/\
LaunchDaemons/org.macports.postgresql96-server/\
postgresql96-server.wrapper start"
alias pg96_stop="sudo  /opt/local/etc/\
LaunchDaemons/org.macports.postgresql96-server/\
postgresql96-server.wrapper stop"

# let git commands auto-complete
if [ -f ~/.local/bin/git-complete ]; then
	source ~/.local/bin/git-complete
fi

# let git commands auto-complete
if [ -f ~/.psql/.pghosts ]; then
	source ~/.psql/.pghosts
fi

# init tmux
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -f $TMUXCONF
fi
