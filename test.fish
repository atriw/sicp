#!/usr/bin/fish

for dir in */
    cd $dir
    for file in *_test.scm
        echo "Testing $file..."
        scheme --quiet < $file
    end
    cd -
end
