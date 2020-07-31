sudo wget https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzvf go1.14.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
sudo wget https://raw.githubusercontent.com/bigmingod/Repo/master/webserver.go
/usr/local/go/bin/go
echo done
/usr/local/go/bin/go build webserver.go
nohup ./webserver &
