#!/bin/bash

function get_random_string() {
    chars='HhQqCcAaIiTtGgPp9Ff10+-.&?<>^#%;,!~=Ww@_'
    chars_len=${#chars}

    len=$chars_len
    if [ $(($1)) -gt 0 ]; then
        len=$1
    fi

    for i in `seq 1 $len`
    do
        pos=$(($RANDOM % $chars_len))
        echo -n ${chars:$pos:1}
    done
}

while true
do
  NOW=ep`date '+%Y%m%d_%H%M%S'`
  value=`get_random_string`
  echo $value > $NOW.hq9
  cat $NOW.hq9 | say -r 160
  ruby mind.rb $NOW.hq9 2>> error.txt
  echo -n $NOW ": " >> log.txt
  echo "$(cat $NOW.hq9)" >> log.txt
  cat $NOW.hq9 | say -r 160
done
