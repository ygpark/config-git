###########################################################
# Variables
#
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export CONFIG_GIT_FLAG_PS1=/tmp/config-git.ps1.$(cut -d ' ' -f 4 /proc/self/stat)


###########################################################
# functions
#

#Brief:
#Usage: 
function git-ps1
{
    if [ "$1" = "init" ];then
        rm -f $CONFIG_GIT_FLAG_PS1
        return 0;
    fi

    if ! [ -f "$CONFIG_GIT_FLAG_PS1" ];then
        export PS1='\[\033[00;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\] \w\[\033[00m\]$(__git_ps1 " (%s)")\$ '
        touch $CONFIG_GIT_FLAG_PS1
    else
        export PS1='\[\033[00;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\] \w\[\033[00m\] \$ '
        rm -f $CONFIG_GIT_FLAG_PS1
    fi
}

#Brief:
#Usage:
function _search
{
    find "$1" -type f -regex $2 -print0 | xargs -0 grep -nH "$3" --color=auto
}

#Brief:
#Usage: search_cs <keyword>
#Usage: search_cs <dir> <keyword>
function search_cs
{
    if [ "$1" = "help" ];then
        echo "Usage:"
        echo "    search_cs <keyword>"
        echo "    search_cs <dir> <keyword>"
        return 0;
    fi

    if [ "$#" = "1" ]; then
        _search "." ".*\(cs\)" "$1"
    elif [ "$#" = "2" ]; then
        _search "$1" ".*\(cs\)" "$2"
    fi
}

function search_cs_f
{
    search_cs $* | sed -e 's/:.*$//g' | sort -u
}


#Brief:
#Usage: search_cs <keyword>
#Usage: search_cs <dir> <keyword>
function search_cpp
{
    if [ "$1" = "help" ];then
        echo "Usage:"
        echo "    search_cpp <keyword>"
        echo "    search_cpp <dir> <keyword>"
        return 0;
    fi

    if [ "$#" = "1" ]; then
        _search "." ".*\(cpp\|h\)" "$1"
    elif [ "$#" = "2" ]; then
        _search "$1" ".*\(cpp\|h\)" "$2"
    fi
}

function search_cpp_f
{
    search_cpp $* | sed -e 's/:.*$//g' | sort -u
}

function encoding-euckr-utf8
{
    current=$(file $1 | cut -d ' ' -f 2)
    if ! [ $current = ISO-8859 ]; then
        echo "Input file is not euc-kr(ISO-8859)"
        return 0;
    fi
    iconv -c -f euc-kr -t utf-8 $1 > $1.tmp
    mv $1.tmp $1
}



###########################################################
# MAIN
#

git-ps1 init
git-ps1
