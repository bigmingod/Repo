sudo wget https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzvf go1.14.6.linux-amd64.tar.gz
echo export PATH="/usr/local/go/bin/:$PATH" >> /etc/bash.bashrc
source /etc/bash.bashrc
sudo wget https://raw.githubusercontent.com/bigmingod/Repo/master/webserver.go
go build webserver.go
nohup ./webserver &
