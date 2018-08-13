#!/usr/bin/env bash

SPARK_HOME=/opt/spark-2.1.1
spark_command="$SPARK_HOME/bin/spark-sql --executor-memory 30g --executor-cores 16 --conf spark.sql.shuffle.partitions=50"
SUCCESS=0
LOG=/home/nfs/logs/dwd_cems.log
:>$LOG
start=19
end=67

for((i=$start;i<=$end;i++));
do
monthstr=`date -d "$i month ago" +%Y%m`
echo "开始执行$monthstr月" >> $LOG 2>&1
spark_command="$spark_command --hivevar monthstr=$monthstr -f /home/nfs/SQL/dwd.fact_cems_gas.sql"
eval $spark_command
if [ $? -eq "$SUCCESS" ]; then
  echo "结束执行$monthstr月" >> $LOG 2>&1
else
  echo "failure执行$monthstr月" >> $LOG 2>&1
fi
done




for((i=2016;i>=2013;i--));
do 
	sh /opt/spark-2.1.1/bin/spark-submit --master spark://cdh-0:7077 --executor-memory 30g --executor-cores 16 complexclean_v10.jar >complexclean.log 2>&1
	a=$((i+1))
	sed -i "s/$a/$i/g" complexclean.properties
	sleep 5m
done
