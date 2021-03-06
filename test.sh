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
	#echo "execution time #2: $(time_helper) seconds";
	#sysctl security.mac.asp
}

declare got_sudo
grab_and_hold_sudo(){
	if sudo -v; then
  	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
  	got_sudo=1
  	return 0
  else
  	return 1
  fi
}
# gorsh, made it so long I need to grab sudo
grab_and_hold_sudo
# start a log stream that should see these events and throw it into the background
# log stream --debug | tee $1 &

sudo powermetrics -u $1 --samplers tasks --show-process-coalition --show-usage-summary -i 0 &
trap "sudo kill -SIGHUP $!" EXIT

# should be a full round-trip + TLS
test

# subsequent tests are still a full round trip, but no TLS
for i in {1..10000}; do
	test
done

# kill job?
kill $!
