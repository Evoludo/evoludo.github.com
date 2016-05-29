#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo -e "Usage:\n\
    $0 <title> [category1 category2 ...]"
    exit 1
fi

date=`date '+%Y-%m-%d %H:%M:%S %z'`
short_date=`date '+%Y-%m-%d'`
title="$1"
shift
categories="$*"
post_dir=_posts
post_file=$short_date-"$title".md
post_path=$post_dir/$post_file

cat > $post_path <<-EOF
---
layout: post
title:  "$title"
date: $date
categories: $categories 
---

EOF
vim + $post_path
