#!/bin/bash

OUTPUT_LOCAT=/home/chenishi/testing/$1
QEMU_SRC=/home/chenishi/git-repos/qemu
INPUT_QCOW2=/home/chenishi/VMs/gdbserver_host.qcow2
OUTPUT_QCOW2=/home/chenishi/VMs/testing.qcow2

# time before execution
T1=$(date +"%s")

# main compression execution
qemu-img convert -O qcow2 -c $INPUT_QCOW2 $OUTPUT_QCOW2 &

while [[ -n $(jobs -r) ]]; do
    echo "$(top -b -n 1 | grep qemu)" | tee -a $OUTPUT_LOCAT
    sleep 1
done

# time after execution
T2=$(date +"%s")

# clean compressed image
rm $OUTPUT_QCOW2
echo "Consumed time = $(($T2 - $T1))"
