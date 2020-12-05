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
