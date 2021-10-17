#!/usr/bin/env bash
languages=`echo "lua typescript javascript nodejs" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

curl cht.sh/$selected/`echo $query | tr ' ' '+'`
