#!/usr/bin/fish

if test ! -f 'assignments.txt'
    echo "No list to download"
    exit 2
end

mkdir -p assignments

set -g curr_dir ''

cat assignments.txt | while read -l line
    if test -z $line
        continue
    end
    string match -rq '#(?<number>\d+) (?<title>[\w\d\s\'-]+)' $line
    if test $status -eq 0
        echo "Downloading $number $title..."
        set -l title (string replace -a ' ' _ $title)
        set -g curr_dir "assignments/$number-$title"
        mkdir -p $curr_dir
    else
        echo "Downloading $line..."
        wget --quiet -P $curr_dir $line
    end
end
