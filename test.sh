# create a junk test script
test(){
	# borrowed from https://news.ycombinator.com/item?id=23278258
	RAND_FILE="/tmp/test-$RANDOM.sh";
	time_helper() { /usr/bin/time $RAND_FILE 2>&1 | tail -1 | awk '{print $1}'; }  # this just returns the real run time
	echo $'#!/bin/sh\necho Hello' $RANDOM > $RAND_FILE && chmod a+x  $RAND_FILE;
	echo "Testing $RAND_FILE";
	#sysctl security.mac.asp
	echo "execution time #1: $(time_helper) seconds";
	#sysctl security.mac.asp
	echo "execution time #2: $(time_helper) seconds";
	#sysctl security.mac.asp
}

# start a log stream that should see these events and throw it into the background
# log stream --debug | tee $1 &

sudo powermetrics --samplers tasks --show-process-coalition --show-process-io --show-process-netstat --show-responsible-pid --show-usage-summary -i 0 | tee $1 &

# should be a full round-trip + TLS
test

# subsequent tests are still a full round trip, but no TLS
for i in {1..10}; do
	test
done

# kill job?
kill $!
