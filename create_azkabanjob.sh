#!/bin/sh

E_WRONG_ARGS=65
NUMBER_OF_EXPECTED_ARGS=2


if [ $# -ne $NUMBER_OF_EXPECTED_ARGS ]
then
    echo "用法: `basename $0` dir jobname"
    echo " 如: `basename $0` /home/nfs/schedulesystem/exp stage_cems_gas.s_gasfachourdata "
    exit $E_WRONG_ARGS
fi


dir=$1
jobname=$2
basepath=$(cd `dirname $0`; pwd)
basepath=$basepath/job
if [ ! -d $basepath ]
then
    mkdir $basepath
fi



echo -e \#$jobname\\r\\ntype=command\\r\\ncommand=python3 $dir/$jobname.py\\r\\nretries=3\\r\\nretry.backoff=5000 > $basepath/$jobname.job