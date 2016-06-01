#!/bin/bash

set -e

function join { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }

if [ -z "$1" ]; then
    echo -e "Usage:\n\
    $0 <title> [category1 category2 ...]" >&2
    exit 1
fi

date=`date '+%Y-%m-%d %H:%M:%S %z'`
short_date=`date '+%Y-%m-%d'`
title="$1"
filename=`sed -e 's/[^A-Z^a-z^0-9]/-/g' <(echo "$title")`
shift
categories=`join '", "' "$@"`
post_dir=_posts
post_file=$short_date-"$filename".md
post_path=$post_dir/$post_file

if [ -f "$post_path" ]; then
    echo "File '$post_file' already exists!" >&2
    exit 1
else 
    cat > "$post_path" <<-EOF
---
layout: post
title:  "$title"
date: $date
categories: ["$categories"]
author: Andrew Bell
---

EOF
fi


vim + +startinsert $post_path
