# CKA Prep
CKA 준비자료

## 1. Setup
- tag 달아주기
  - master
  - worker
- 설정
  - id : user
  - pw : 123456

```
user@jesang-myung-9cf25ac51:~$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16
[sudo] password for user:
[init] using Kubernetes version: v1.11.2
[preflight] running pre-flight checks
I0902 20:30:10.524959   16059 kernel_validator.go:81] Validating kernel version
I0902 20:30:10.525334   16059 kernel_validator.go:96] Validating kernel config
[preflight/images] Pulling images required for setting up a Kubernetes cluster
[preflight/images] This might take a minute or two, depending on the speed of your internet connection
[preflight/images] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[preflight] Activating the kubelet service
[certificates] Generated ca certificate and key.
[certificates] Generated apiserver certificate and key.
[certificates] apiserver serving cert is signed for DNS names [jesang-myung-9cf25ac51.mylabserver.com kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs
[10.96.0.1 172.31.25.246]
[certificates] Generated apiserver-kubelet-client certificate and key.
[certificates] Generated sa key and public key.
[certificates] Generated front-proxy-ca certificate and key.
[certificates] Generated front-proxy-client certificate and key.
[certificates] Generated etcd/ca certificate and key.
[certificates] Generated etcd/server certificate and key.
[certificates] etcd/server serving cert is signed for DNS names [jesang-myung-9cf25ac51.mylabserver.com localhost] and IPs [127.0.0.1 ::1]
[certificates] Generated etcd/peer certificate and key.
[certificates] etcd/peer serving cert is signed for DNS names [jesang-myung-9cf25ac51.mylabserver.com localhost] and IPs [172.31.25.246 127.0.0.1 ::1]
[certificates] Generated etcd/healthcheck-client certificate and key.
[certificates] Generated apiserver-etcd-client certificate and key.
[certificates] valid certificates and keys now exist in "/etc/kubernetes/pki"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/admin.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/kubelet.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/controller-manager.conf"
[kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/scheduler.conf"
[controlplane] wrote Static Pod manifest for component kube-apiserver to "/etc/kubernetes/manifests/kube-apiserver.yaml"
[controlplane] wrote Static Pod manifest for component kube-controller-manager to "/etc/kubernetes/manifests/kube-controller-manager.yaml"
[controlplane] wrote Static Pod manifest for component kube-scheduler to "/etc/kubernetes/manifests/kube-scheduler.yaml"
[etcd] Wrote Static Pod manifest for a local etcd instance to "/etc/kubernetes/manifests/etcd.yaml"
[init] waiting for the kubelet to boot up the control plane as Static Pods from directory "/etc/kubernetes/manifests"
[init] this might take a minute or longer if the control plane images have to be pulled
[apiclient] All control plane components are healthy after 39.002903 seconds
[uploadconfig] storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.11" in namespace kube-system with the configuration for the kubelets in the cluster
[markmaster] Marking the node jesang-myung-9cf25ac51.mylabserver.com as master by adding the label "node-role.kubernetes.io/master=''"
[markmaster] Marking the node jesang-myung-9cf25ac51.mylabserver.com as master by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[patchnode] Uploading the CRI Socket information "/var/run/dockershim.sock" to the Node API object "jesang-myung-9cf25ac51.mylabserver.com" as an annotation
[bootstraptoken] using token: 4ssaac.6pss4dmnfql6dkqm
[bootstraptoken] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstraptoken] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstraptoken] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstraptoken] creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join 172.31.25.246:6443 --token 4ssaac.6pss4dmnfql6dkqm --discovery-token-ca-cert-hash sha256:a7cdd3dff1e95096ec01b17b48d778eba00e51c86550f9335237e5763f68f55d
```


## Raw Kubernetes Install

### Ubuntu

```
cat << EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sudo apt install -y docker.io
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-key list
```
```
root@jesang-myung-9cf25ac51:~# cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
> deb http://apt.kubernetes.io/ kubernetes-xenial main
> EOF
root@jesang-myung-9cf25ac51:~# cat /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
root@jesang-myung-9cf25ac51:~# apt update
Hit:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial InRelease
Hit:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates InRelease
Hit:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-backports InRelease
Hit:4 http://security.ubuntu.com/ubuntu xenial-security InRelease                                                
Get:5 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8,993 B]                                
Get:6 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 Packages [19.1 kB]
Fetched 28.1 kB in 1s (19.7 kB/s)     
Reading package lists... Done
Building dependency tree       
Reading state information... Done
1 package can be upgraded. Run 'apt list --upgradable' to see it.
root@jesang-myung-9cf25ac51:~# apt install -y kubelet kubeadm kubectl
root@jesang-myung-9cf25ac51:~# kubeadm init --pod-network-cidr=10.244.0.0/16
```

```
kubeadm join 172.31.25.7:6443 --token p7w0iv.fqxrckwq97elg2ta --discovery-token-ca-cert-hash sha256:76101541382bccd689d2661a86e04b443cbb8d329109437a0a2bbd94168e69ab
```


```
user@jesang-myung-9cf25ac51:~$ k apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.extensions/kube-flannel-ds created
user@jesang-myung-9cf25ac51:~$ k get po --all-namespaces
NAMESPACE     NAME                                                             READY     STATUS    RESTARTS   AGE
kube-system   coredns-78fcdf6894-6klq6                                         1/1       Running   0          11m
kube-system   coredns-78fcdf6894-xqv7q                                         1/1       Running   0          11m
kube-system   etcd-jesang-myung-9cf25ac51.mylabserver.com                      1/1       Running   0          10m
kube-system   kube-apiserver-jesang-myung-9cf25ac51.mylabserver.com            1/1       Running   0          11m
kube-system   kube-controller-manager-jesang-myung-9cf25ac51.mylabserver.com   1/1       Running   0          10m
kube-system   kube-flannel-ds-5j88n                                            1/1       Running   0          11s
kube-system   kube-proxy-hbfrd                                                 1/1       Running   0          11m
kube-system   kube-scheduler-jesang-myung-9cf25ac51.mylabserver.com            1/1       Running   0          11m
```

> worker
```
user@jesang-myung-9cf25ac52:~$ sudo -i
[sudo] password for user:
root@jesang-myung-9cf25ac52:~# apt install -y docker.io
```



## Lecture: Deployments, Rolling Updates, and Rollbacks

```
k create -f nginx-deployment.yaml
k get deploy nginx-deployment -o yaml
k set image deployment/nginx-deployment nginx=nginx:1.8
k rollout status deployment/nginx-deployment
```
```
user@jesang-myung-9cf25ac51:~$ k rollout history deployment/nginx-deployment --revision=3
deployments "nginx-deployment" with revision #3
Pod Template:
  Labels:       app=nginx
        pod-template-hash=1473201042
  Containers:
   nginx:
    Image:      nginx:1.91
    Port:       80/TCP
    Host Port:  0/TCP
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>

user@jesang-myung-9cf25ac51:~$ k rollout history deployment/nginx-deployment --revision=2
deployments "nginx-deployment" with revision #2
Pod Template:
  Labels:       app=nginx
        pod-template-hash=3975636852
  Containers:
   nginx:
    Image:      nginx:1.8
    Port:       80/TCP
    Host Port:  0/TCP
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
```

k rollout undo deployment/nginx-deployment --to-revision=2






## How Kubernetes Configures Applications

```
k create configmap my-map --from-literal=school=LinuxAcademy
k get configmap
k describe configmap my-map
```

`k create -f pod-config.yaml`

```
user@jesang-myung-9cf25ac51:~/template$ k log config-test-pod
log is DEPRECATED and will be removed in a future version. Use logs instead.
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_SERVICE_PORT=443
HOSTNAME=config-test-pod
SHLVL=1
HOME=/root
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_PROTO=tcp
WHAT_SCHOOL=LinuxAcademy
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_SERVICE_HOST=10.96.0.1
PWD=/
```

`env-dump.yaml`

```
user@jesang-myung-9cf25ac51:~$ k describe cm exam-map
Name:         exam-map
Namespace:    default
Labels:       <none>
Annotations:  <none>
Data
====
school:
----
LinuxAcademy
studentName:
----
Jesang Myung
kubernetes:
----
is awesome
Events:  <none>
```


```
user@jesang-myung-9cf25ac51:~$ k logs env-dump
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=env-dump
STUDENT_NAME=Jesang Myung
SCHOOL=LinuxAcademy
KUBERNETES=is awesome
KUBERNETES_SERVICE_HOST=10.96.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
HOME=/root
```


## Lecture: Scaling Applications

`k scale deploy nginx-deployment --replicas=3`


## Lecture: Self-Healing Applications
