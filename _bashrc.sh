function git-ps1-on
{
    source $HOME/.config-git/script/ps1-on.sh
}

function git-ps1-off
{
    source $HOME/.config-git/script/ps1-off.sh
}

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
