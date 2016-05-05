#!/bin/bash

for i in `seq 0 30`;do

ambtemp=`elinks -dump -dump-width 400 -no-numbering -no-references http://admin:admin@c0-$i/sensors.html|grep AMB|awk {'print$9'}`
cpu0temp=`elinks -dump -dump-width 400 -no-numbering -no-references http://admin:admin@c0-$i/sensors.html|grep Dmn|grep -v Unavailable|grep CPU0|awk {'print$9'}`
cpu1temp=`elinks -dump -dump-width 400 -no-numbering -no-references http://admin:admin@c0-$i/sensors.html|grep Dmn|grep -v Unavailable|grep CPU1|awk {'print$9'}`

echo -e "Temp compute-0-$i: AMB Temp $ambtemp C"


done
