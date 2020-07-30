sudo wget https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzvf go1.14.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
sudo wget https://lsmstorage0730.blob.core.windows.net/lsmcontainer0730/webserver.go
go build webserver.go
nohup ./webserver &
