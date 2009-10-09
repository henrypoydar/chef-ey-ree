#!/bin/sh

#
# run under sudo
#

echo
echo "--------------"
echo "START"
echo

gem sources -a http://gems.opscode.com
gem install ohai chef --no-rdoc --no-ri
chef-solo -l debug -c config/solo.rb -j config/dna.json

echo
echo "COMPLETE"
echo "------------------------"
echo
