#!/bin/bash
k1=`ps | grep "/root/Box/BoxPlayer/BoxIOServices"|grep -v grep|awk '{print $1}'`
echo $k1
kill -9 $k1
k2=`ps | grep "/root/Box/BoxPlayer/BoxPlayer"|grep -v grep|awk '{print $1}'`
echo $k2
kill -9 $k2
