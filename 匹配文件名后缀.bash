#!/bin/sh


#tar zxvPf s_psbaseinfo > /dev/null
for file in `ls /home/hivedata/stage_cems_common/`
do
        echo ${file##*.} 
        if [ "${file##*.}" = "gz" ]; then 
                echo “压缩文件”
        else
                echo "非压缩文件"
        fi
done




#!/bin/sh


#tar zxvPf s_psbaseinfo > /dev/null
for file in `ls /home/hivedata/stage_cems_common/`
do
        echo ${file##*.} 
        if expr "$file" : '.*.gz' > /dev/null ; then 
                echo “压缩文件”
        else
                echo "非压缩文件"
        fi
done