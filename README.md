# fack-centos-squid
This script can help you install squid3 in centos7.0 or centos6.0

一个能在centos6/7快速搭建squid代理的脚本  
使用方法  
wget https://github.com/LunacyZeus/fack-centos-squid/raw/master/centos7-squid.sh && sh centos7-squid.sh --no-check-certificate  
如果wget不能用请yum install -y wget  
常用命令如下  

[centos6.0]  
service squid restart#重启代理  
service squid start#开启代理  
service squid stop#关闭代理  
chkconfig squid on#设置开机自启  

[centos7.0]  
systemctl restart squid#重启代理  
systemctl start squid#开启代理  
systemctl stop squid#关闭代理  
systemctl enable squid#设置开机自启  
