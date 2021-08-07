function push-exercise --argument chapter num
    if test (count $argv) -ne 2
        return 2
    end
    set -l file $chapter/$chapter.$num
    scheme --quiet < $file"_test.scm"
    if test $status -ne 0
        return $status
    end
    ga $file.scm
    ga $file"_test.scm"
    gc -m "Exercise: $chapter.$num"
end
