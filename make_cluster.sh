swapoff -a
apt install -y docker.io
cat << EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat << EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt update -y
apt-get install kubernetes-cni=0.6.0-00 -y
apt install -y kubelet="1.11.1-00" kubectl="1.11.1-00" kubeadm="1.11.1-00"
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$PUBLICIP
