#!/bin/bash
#


# define location of rrdtool databases
rrd="/var/lib/rrd"
# define location of images
img="/var/www/html/ganglia/temp"

nodes=`cat /etc/hosts|grep comp|awk '{print$3}'`

for node in $nodes;do
	# set default temp value
	temp="0"
	# rename to ilo
	manager=`echo $node|cut -f 2,3 -d"-"`
	# get sensor data
	`curl --user admin:admin --digest --connect-timeout 10 -f -m 15 -s -o /tmp/sensor.html http://manager-$manager/sensors.html`
	`elinks -dump -dump-width 400 -no-numbering -no-references /tmp/sensor.html > /tmp/sensor.tmp`
	# check node type
	type=`echo $manager|grep "0-"|wc -l`
	# check if temp sensor data is available
	temp=`cat /tmp/sensor.tmp|grep "AMB"|grep "Unavailable"|wc -l`
	if [ $type == 1 ]; then
		# dl140
		if [ $temp == 1 ]; then
			# if not available then set default temp to 15 deg
			temp="0"
		else
			temp=`cat /tmp/sensor.tmp|grep "AMB"|grep "Upper"|wc -l`
			if [ $temp == 1 ]; then
				temp=`cat /tmp/sensor.tmp|grep "AMB"|awk '{print$10}'`
			else
				temp=`cat /tmp/sensor.tmp|grep "AMB"|awk '{print$11}'`
			fi
		fi
	else
	        # dl160
                temp=`cat /tmp/sensor.tmp |grep "Rear Ambient"|cut -f 6 -d"|"|awk '{print$1}'`
	fi
	echo  $node $temp
	# if rrdtool database doesn't exist, create it
	if [ ! -f $rrd/$node.rrd ];then
		`rrdtool create $rrd/$node.rrd -s 300 \
			DS:temp:GAUGE:600:0:75 \
			RRA:AVERAGE:0.5:1:576 \
			RRA:AVERAGE:0.5:6:672 \
			RRA:AVERAGE:0.5:24:732 \
			RRA:AVERAGE:0.5:144:1460`
	fi

	# update rrds
	`rrdtool update $rrd/$node.rrd N:$temp`

	# clean up
	`rm -f /tmp/sensor.tmp` >/dev/null
	`rm -f /tmp/sensor.html` >/dev/null
done

# create graphs
`$HOME/bin/graph_cluster.sh` >/dev/null
#echo "Graph finished"
