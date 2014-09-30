#!/bin/sh

cd /tmp/convertVideo
cd `ls -alt | awk NR==2 | awk '{ print $9 }'`

orig=`ls -al | awk NR==5 | awk '{ print $5 }'`
filename=`ls -al | awk NR==5`
sleep 2
diff=`ls -al | awk NR==5 | awk '{ print $5 }'`

if [ $orig == $diff ]; then
        kill -9 `ps aux | grep ffmpeg | awk '{print $2}'`
        echo $filename > killff.log
        exit 1
fi
