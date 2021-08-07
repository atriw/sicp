function t -a path
    if test (count $argv) -ne 1
        exit 2
    end
    scheme --quiet < $path
    if test $status -ne 0
        return $status
    end
end
