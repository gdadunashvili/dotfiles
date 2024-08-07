#!/usr/bin/env bash 

languages_line=`echo "golang lua cpp c typescript nodejs" | tr  ' ' '\n'`
languages=`echo $languages_line | tr  ' ' '\n'`
core_utils=`echo "xargs find mv sed awk grep read" | tr  ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "querey: " query

printf "$languages_line" | egrep $selected
result="$?"
if [ "$result" == 0 ]; then
  # tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
  curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done
else
  curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done
fi



