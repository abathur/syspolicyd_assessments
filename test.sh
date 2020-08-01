# create a junk test script
echo 'echo $RANDOM' > test1
echo 'echo $RANDOM' > test2
chmod 755 test1 test2

# start a log stream that should see these events and throw it into the background
log stream --debug --info --predicate 'process == "syspolicyd" AND subsystem == "com.apple.securityd" AND category == "gk"' &

# should be a full round-trip + TLS
time ./test1

# should be cached
time ./test1

# same content; shouldn't be cached, but just round-trip
time ./test2

# kill job?
kill $!
