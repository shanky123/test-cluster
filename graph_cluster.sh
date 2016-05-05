#!/bin/bash
#


# define location of rrdtool databases
rrd="/var/lib/rrd"
# define location of images
img="/var/www/html/ganglia/temp"

# nodes=`cat /etc/hosts|grep c0|cut -f2`
nodes=`cat /etc/hosts|grep comp|awk '{print$3}'`

for node in $nodes;do
	for int in "day" "week" "month" "year";do
		echo $node
		`rrdtool graph $img/$node-$int.png -t "$int" -s -1$int -w 500 -h 150 -a PNG DEF:$node=$rrd/$node.rrd:temp:AVERAGE LINE1:$node#000000:$node GPRINT:$node:LAST:%2.0lf%s\\deg >/dev/null`
	done
#	color=`python color.py $i`
#	defarray[$i]="DEF:$node=$rrd/$node.rrd:temp:AVERAGE "
#	linearray[$i]="LINE1:$node$color:$node GPRINT:$node:LAST:%2.0lf%s\\l "
#	i=`echo $(( $i + 1 ))`
done

# bygg kommando

#def=""
#line=""
#gprint=""
#i="1"
#for node in $nodes;do
#	def=$def${defarray[$i]}
#	line=$line${linearray[$i]}
#	i=`echo $(( $i + 1 ))`
#done

# graph 
#for int in "day" "week" "month" "year";do
#	`rrdtool graph $img/temp-$int.png -t "$int" -s -1$int -w 600 -h 300 -a PNG \
#	$def \
#	$line \
#	>/dev/null`
#done
