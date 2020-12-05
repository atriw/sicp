function push-exercise --argument chapter num
    if test (count $argv) -ne 2
        return 2
    end
    set -l file $chapter.$num
    cd $chapter
    scheme --quiet < $file"_test.scm"
    if test $status -ne 0
        cd -
        return $status
    end
    cd -
    ga $chapter/$file.scm
    ga $chapter/$file"_test.scm"
    gc -m "Exercise: $file"
end
