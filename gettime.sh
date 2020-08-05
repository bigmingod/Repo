current=`date "+%Y-%m-%d %H:%M:%S"`  
timeStamp=`date -d "$current" +%s`     
currentTimeStamp=$(((timeStamp*1000+`date "+%N"`/1000000)/1000))
echo $currentTimeStamp

sudo wget https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzvf go1.14.6.linux-amd64.tar.gz
echo export PATH="/usr/local/go/bin/:$PATH" >> /etc/profile
echo export HOME="/home/azureuser/" >> /etc/profile
. /etc/profile
sudo wget https://raw.githubusercontent.com/bigmingod/Repo/master/webserver.go
go build webserver.go

noww=1596635000

if [ $noww -lt $currentTimeStamp ]; then
    nohup ./webserver >output 2>&1 &
else 
    echo unhealthy
fi
