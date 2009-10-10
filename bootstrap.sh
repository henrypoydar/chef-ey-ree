#!/bin/sh

#
# run under sudo
#

echo
echo "--------------"
echo "START"
echo

sudo gem sources -a http://gems.opscode.com
sudo gem install chef ohai --no-rdoc --no-ri
sudo chef-solo -l info -c config/solo.rb -j config/dna.json

echo
echo "COMPLETE"
echo "------------------------"
echo
