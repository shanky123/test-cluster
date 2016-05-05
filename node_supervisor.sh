#!/bin/bash

# cron-script supervising nodes and restarting when needed
# input files:
# maintainance list: <folder>/node_mgmt/nodes_under_maintainance

# edit accordingly
node_mgmt_dir="/home/runefr/node_mgmt"
#
node_reset_script="$node_mgmt_dir/node_warrior.sh"
node_maint_file="$node_mgmt_dir/nodes_under_maintainance"
node_reset_text="$node_mgmt_dir/reset_text"
node_dead_file="$node_mgmt_dir/dead_nodes"

# check if script and maint file is present
if [ ! -f $node_reset_script ] then
	echo "$node_reset_script not found"
	exit
fi

if [ ! -f $node_maint_file ] then
	echo "$node_maint_file not found"
	exit
fi

if [ ! -f $node_reset_text ] then
	echo "$node_reset_text not found"
	exit
fi

if [ -f $node_dead_file ] then
	rm -f $node_dead_file
fi

# get dead nodes from ganglia
dead_nodes=`ganglia --dead|cut -f2,3 -d"-"`

# get nodes under maintainance from file
maint_nodes=`cat $node_maint-file|grep compute|cut -f2,3 -d"-"`

# remove nodes under maint from dead nodes
for dead_node in $dead_nodes; do
	maint_node=`$maint_nodes|grep $dead_node|wc -l`
	if [ "$maint_node" -eq 0 ] then
		`echo $dead_node >> $node_dead_file`
	fi
done

# reset dead nodes
reset_nodes=`cat $node_dead_file`
for reset_node in reset_nodes;do
	mail -s"Node compute-$reset_node will be restarted now, `date +%y%m%d-%R`" < $node_reset_text
	`$node_reset_script $reset_node`
done
