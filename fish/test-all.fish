function test-all
    for file in */*_test.scm
        echo "Testing $file..."
        scheme --quiet < $file
        if test $status -ne 0
            return $status
        end
    end
end
