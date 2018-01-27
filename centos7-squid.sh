#!/bin/bash

export LANG=UTF-8
export LANGUAGE=UTF-8

echo "本脚本只适用于yum源有squid3.0+以上版本的,默认代理设置为高匿名,端口为31280,搭建成功就可用"

echo "安装squid httpd-tools"
yum -y install squid httpd-tools
echo "httpd-tools squid密码设置请自行输入命令"
echo "htpasswd -b -c /etc/squid/passwd $squid_user $squid_password"
#htpasswd -b -c /etc/squid/passwd $squid_user $squid_password

echo "备份squid配置 => /etc/squid/squid.conf.bak"
mv /etc/squid/squid.conf /etc/squid/squid.conf.bak

touch /etc/squid/blacklist.acl

echo "获取git源上的squid配置 => https://github.com/LunacyZeus/fack-centos-squid/raw/master/squid.conf"
wget -O /etc/squid/squid.conf --no-check-certificate  https://github.com/LunacyZeus/fack-centos-squid/raw/master/squid.conf

echo "放行squid代理端口"
iptables -I INPUT -p tcp --dport 31280 -j ACCEPT
#/sbin/iptables-save

echo "保存防火墙规则"
/sbin/service iptables save

echo "获取centos版本号"
VERSION=$(cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/')
echo 当前为Centos $VERSION

if [ $SYSTEM = "6" ] ; then #centos6
echo "启动squid代理"
service squid restart
echo "设置开机自启"
chkconfig squid on


elif [ $SYSTEM = "7" ] ; then #centos7
echo "启动squid代理"
/bin/systemctl restart squid
echo "设置开机自启"
/bin/systemctl enable squid
else
echo "获取centos版本失败,请自行输入命令启动,命令请参阅git源的说明文件"
