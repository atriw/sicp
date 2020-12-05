function start-exercise --argument chapter num
    if test (count $argv) -ne 2
        exit 2
    end
    set -l file $chapter.$num
    vim -o $chapter/$file.scm $chapter/$file"_test.scm"
end
