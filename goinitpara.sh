sudo wget https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzvf go1.14.6.linux-amd64.tar.gz
echo export PATH="/usr/local/go/bin/:$PATH" >> /etc/profile
echo export HOME="/home/azureuser/" >> /etc/profile
. /etc/profile
sudo wget https://raw.githubusercontent.com/bigmingod/Repo/master/webserverpara.go
go build webserverpara.go
nohup ./webserverpara $1 $2 >output 2>&1 &
