#!/bin/bash
startdate="01-OCT-2016"
enddate="03-OCT-2017"
d=${startdate}
n=0
until [ "$d" = "${enddate}" ]
do
  n=$((n+1))
  d=$(date -d "$startdate + $n days" +%d-%h-%Y | tr [:lower:] [:upper:])
  echo $d
done
