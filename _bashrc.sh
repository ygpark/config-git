function git-ps1-on
{
    source $HOME/.config-git/script/ps1-on.sh
}

function git-ps1-off
{
    source $HOME/.config-git/script/ps1-off.sh
}

function search_cs
{
    #find . -type f -regex ".*\(cs\|resx\)" -print0 | xargs -0 grep -nH $1 --color=auto
    find "$1" -type f -regex ".*\(cs\)" -print0 | xargs -0 grep -nH "$2" --color=auto
}

function search_cs_f
{
    search_cs $* | sed -e 's/:.*$//g' | sort -u
}
