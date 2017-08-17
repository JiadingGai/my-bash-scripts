#!/bin/bash
startdate="01-OCT-2016"
enddate="01-MAY-2017"
d=
n=0
until [ "$d" = "$enddate" ]
do
  d=$(date -d "$startdate + $n days" +%d-%h-%Y | tr [:lower:][:upper:])
  echo $d
done
