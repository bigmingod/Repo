cur_sec_and_ns=`date '+%s-%N'`
Ncur_ns=`date '+%N'`
cur_sec=${cur_sec_and_ns%-*}
cur_ns=${cur_sec_and_ns##*-}
echo 当前秒_纳秒=$cur_sec_and_ns
echo 当前秒=$cur_sec

sudo wget https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzvf go1.14.6.linux-amd64.tar.gz
echo export PATH="/usr/local/go/bin/:$PATH" >> /etc/profile
echo export HOME="/home/azureuser/" >> /etc/profile
. /etc/profile
sudo wget https://raw.githubusercontent.com/bigmingod/Repo/master/webserver.go
go build webserver.go

noww=1596638000
echo $cur_sec

if [ $noww -lt $cur_sec ]; then
    nohup ./webserver >output 2>&1 &
else 
    echo unhealthy
fi
