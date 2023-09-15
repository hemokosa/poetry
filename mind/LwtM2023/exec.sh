#!/bin/sh
while true
do
  NOW=ep`date '+%Y%m%d_%H%M%S'`
  cp -p ./temp.hq9 $NOW.hq9
  cat $NOW.hq9 | say -v Samantha
  ruby mind.rb $NOW.hq9
done
