#!/usr/bin/fish

set -l argc (count $argv)

if test $argc -ne 1
    echo "Wrong input number $argc"
    exit 2
end

set -l path $argv[1]

set -l dir (dirname $path)

set -l base (basename $path)

echo "Testing $base..."
cd $dir
scheme --quiet < $base
cd -
