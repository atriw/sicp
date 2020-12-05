function test-all
    for dir in */
        pushd $dir
        for file in *_test.scm
            echo "Testing $file..."
            scheme --quiet < $file
            if test $status -ne 0
                popd
                return $status
            end
        end
        popd
    end
end

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

function start-exercise --argument chapter num
    if test (count $argv) -ne 2
        exit 2
    end
    set -l file $chapter.$num
    vim -o $chapter/$file.scm $chapter/$file"_test.scm"
end

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
