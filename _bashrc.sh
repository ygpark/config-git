###########################################################
# functions
#

#Brief:
#Usage:
function gitf
{
    flag=/tmp/config-git.ps1
    if [ "$1" = "ps1" ]; then
        if [ -f "$flag" ];then
            source $HOME/.config-git/script/ps1-off.sh
            rm -f $flag
        else
            source $HOME/.config-git/script/ps1-on.sh
            touch $flag
        fi
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



###########################################################
# PS1 for git
#
source /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

gitf ps1
