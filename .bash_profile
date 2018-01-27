# $HOME/.bash_profle


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


# FUNCTIONS

# unpack known archives Usage: extract <archive> [<dest>]
extract () {
    if [ -f "$1" ] ; then
        dest=.
        if [ ! -z "$2" ] ; then
            if [ -d "$2" ] ; then
                dest="$2"
            else
                echo "extract: $2 directory does not exist"
                return 1
            fi
        fi
        case $1 in
            *.tar.bz2)   tar xvjf "$1"    ;;
            *.tar.gz)    tar xvzf "$1" -C "$dest";;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xvf "$1" -C "$dest" ;;
            *.tbz2)      tar xvjf "$1"    ;;
            *.tgz)       tar xvzf "$1"    ;;
            *.zip)       unzip "$1" -d "$dest"   ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x  "$1"        ;;
            *)           echo "extract: $1 can't be extracted" ;;
        esac
    else
        echo "extract: $1 is not a valid file"
        return 1
   fi
}

# put git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# let git commands auto-complete
if [ -f ~/.local/bin/git-complete ]; then
	source ~/.local/bin/git-complete
fi

# read postgres hosts file
if [ -f ~/.pghosts ]; then
	source ~/.pghosts
fi

source ~/.alias
