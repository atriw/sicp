function t -a path
    if test (count $argv) -ne 1
        exit 2
    end
    set -l dir (dirname $path)
    set -l base (basename $path)
    cd $dir
    scheme --quiet < $base
    if test $status -ne 0
        cd -
        return $status
    end
    cd -
end
