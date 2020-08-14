sudo apt update
sudo apt upgrade -y
sudo apt install -y openvswitch-switch ebtables jq uuid
sudo modprobe br_netfilter
sudo sh -c "echo br_netfilter > /etc/modules-load.d/br_netfilter.conf"

sudo apt-get install runc

sudo wget https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/v1.18.3/bin/linux/amd64/kubelet
chmod +x kubelet
wget -O /home/azureuser/specfiles/staticpod.yaml https://raw.githubusercontent.com/bigmingod/Repo/master/staticpod.yaml

wget https://github.com/containernetworking/plugins/releases/download/v0.8.6/cni-plugins-linux-amd64-v0.8.6.tgz
mkdir cni-plugin
tar -xvf  cni-plugins-linux-amd64-v0.8.6.tgz -C cni-plugin
mkdir -p /opt/cni/bin
sudo cp -r ./cni-plugin/* /opt/cni/bin

mkdir -p /etc/cni/net.d
wget -O /etc/cni/net.d/10-mynet.conf https://raw.githubusercontent.com/bigmingod/Repo/master/10-mynet.conf
wget -O /etc/cni/net.d/99-loopback.conf https://raw.githubusercontent.com/bigmingod/Repo/master/99-loopback.conf


wget "https://github.com/containerd/containerd/releases/download/v1.2.6/containerd-1.2.6.linux-amd64.tar.gz"
sudo tar -xvf containerd-1.2.6.linux-amd64.tar.gz -C /usr/local/
sudo curl -o /etc/systemd/system/containerd.service "https://raw.githubusercontent.com/containerd/cri/master/contrib/systemd-units/containerd.service"
sudo systemctl daemon-reload
sudo systemctl enable containerd
sudo systemctl start containerd
sudo mkdir /etc/containerd
sudo sh -c "containerd config default > /etc/containerd/config.toml"

wget https://raw.githubusercontent.com/bigmingod/Repo/master/containerdconfig.toml
sudo mv containerdconfig.toml /etc/containerd/config.toml
sudo systemctl restart containerd

export VERSION="v1.17.0"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz

sudo crictl config
sudo sh -c "echo runtime-endpoint: unix:///run/containerd/containerd.sock >> /etc/crictl.yaml"
sudo sh -c "echo image-endpoint: unix:///run/containerd/containerd.sock >> /etc/crictl.yaml"
sudo sh -c "echo timeout: 2 >> /etc/crictl.yaml"
sudo sh -c "echo debug: true >> /etc/crictl.yaml"

nohup ./kubelet --cgroup-driver=systemd --pod-manifest-path=/home/azureuser/specfiles -v 2 --fail-swap-on=false --pod-cidr 10.22.0.0/16 --network-plugin=kubenet --non-masquerade-cidr 10.0.0.0/8 --cluster-dns 8.8.8.8 --container-runtime remote --container-runtime-endpoint unix:///run/containerd/containerd.sock &
