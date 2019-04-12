#!/bin/bash

set -e

[ "$DEBUG" == "1" ] && set -x && set -e

INSTANCE_NAME="${INSTANCE_NAME:glusterfs.marathon.mesos}" 


mkdir -p $GLUSTER_PATH/$GLUSTER_VOL
WAIT=$(( ( RANDOM % 10 )  + 5 ))
echo "Wait $WAIT seconds before start"
sleep $WAIT

export MY_EXT_IP=$HOST
echo "My external IP address: $MY_EXT_IP"
export GLUSTER_PEERS=`dig +short $INSTANCE_NAME`
if [ -z "$GLUSTER_PEERS" ];then
   echo "No peers found for $INSTANCE_NAME"
fi
echo -e "$INSTANCE_NAME instances are:\n $GLUSTER_PEERS"

# Change root password
echo "root:$SSH_PASS" | chpasswd



echo "Starting glusterfs ..."
/usr/sbin/glusterd -p /var/run/glusterd.pid  
# Wait for glusterfs to start

echo "Starting sshd ..."
/usr/sbin/sshd -D 
