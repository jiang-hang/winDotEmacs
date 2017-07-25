# ------------------------
# prompt
# ------------------------
# export PS1="[\w] "
export PS1="[\w] "

if [ "$PS" == "" ] ; then
    export PS1="[\w] \$ "
    if [ "$TERM" == "xterm" ] ; then
        export PS1="\[\e[34m\]xterm\$ \[\e[0m\]"
    elif [ "$TERM" == "cygwin" ] ; then
        export PS1="\[\e[32;1m\]cygwin\$ \[\e[0m\]"
    fi
fi

if [ "$TERM" == "xterm" ] ; then
    PROMPT_COMMAND='echo -ne "\e]0;${HOSTNAME} - ${PWD}\007"'
fi

# ------------------------
# path
# ------------------------
PATH=.
PATH=$PATH:/cygdrive/c/cygwin64/bin
PATH=$PATH:/usr/x11R6/bin
PATH=$PATH:/usr/bin
PATH=$PATH:`cygpath -S`
PATH=$PATH:`cygpath -W`

# ------------------------
# alias
# ------------------------
alias h=history
alias rm="rm -i"
alias ls="ls -C"
alias lt="ls -rtl"
