#!/usr/bin/fish

for dir in */
    cd $dir
    for file in *_test.scm
        echo "Testing $file..."
        scheme --quiet < $file
        if test $status -ne 0
            exit $status
        end
    end
    cd -
end
