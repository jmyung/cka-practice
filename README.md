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
sudo apt install -y docker.io
cat << EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-key list
```
```
cat << EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
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

## Lecture: Resource Limits & Pod Scheduling

`user@jesang-myung-9cf25ac51:~/template$ k describe no`

```
 jesang-myung-9cf25ac51.mylabserver.com
Name:               jesang-myung-9cf25ac51.mylabserver.com
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    color=black
                    kubernetes.io/hostname=jesang-myung-9cf25ac51.mylabserver.com
                    node-role.kubernetes.io/master=
Annotations:        flannel.alpha.coreos.com/backend-data={"VtepMAC":"96:a6:bc:05:41:3b"}
                    flannel.alpha.coreos.com/backend-type=vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager=true
                    flannel.alpha.coreos.com/public-ip=172.31.23.176
                    kubeadm.alpha.kubernetes.io/cri-socket=/var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl=0
                    volumes.kubernetes.io/controller-managed-attach-detach=true
CreationTimestamp:  Fri, 14 Sep 2018 10:55:43 +0000
Taints:             node-role.kubernetes.io/master:NoSchedule
Unschedulable:      false
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  OutOfDisk        False   Sat, 22 Sep 2018 14:40:06 +0000   Fri, 14 Sep 2018 10:55:40 +0000   KubeletHasSufficientDisk     kubelet has sufficient disk space available
  MemoryPressure   False   Sat, 22 Sep 2018 14:40:06 +0000   Fri, 14 Sep 2018 10:55:40 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Sat, 22 Sep 2018 14:40:06 +0000   Fri, 14 Sep 2018 10:55:40 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Sat, 22 Sep 2018 14:40:06 +0000   Fri, 14 Sep 2018 10:55:40 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Sat, 22 Sep 2018 14:40:06 +0000   Fri, 14 Sep 2018 11:07:34 +0000   KubeletReady                 kubelet is posting ready status. AppArmor enabled
Addresses:
  InternalIP:  172.31.23.176
  Hostname:    jesang-myung-9cf25ac51.mylabserver.com
Capacity:
 cpu:                2
 ephemeral-storage:  20263528Ki
 hugepages-2Mi:      0
 memory:             8173808Ki
 pods:               110
Allocatable:
 cpu:                2
 ephemeral-storage:  18674867374
 hugepages-2Mi:      0
 memory:             8071408Ki
 pods:               110
System Info:
 Machine ID:                 e156aebfbcac49b4bed31684a6b812cb
 System UUID:                EC2ACF82-85A2-7454-CACE-C4F1E1591FB2
 Boot ID:                    77210623-fcce-409e-94d0-fb1f24076a98
 Kernel Version:             4.4.0-1066-aws
 OS Image:                   Ubuntu 16.04.5 LTS
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://17.3.2
 Kubelet Version:            v1.11.3
 Kube-Proxy Version:         v1.11.3
PodCIDR:                     10.244.0.0/24
Non-terminated Pods:         (8 in total)
  Namespace                  Name                                                              CPU Requests  CPU Limits  Memory Requests  Memory Limits
  ---------                  ----                                                              ------------  ----------  ---------------  -------------
  kube-system                coredns-78fcdf6894-dh4ff                                          100m (5%)     0 (0%)      70Mi (0%)        170Mi (2%)
  kube-system                coredns-78fcdf6894-srkqv                                          100m (5%)     0 (0%)      70Mi (0%)        170Mi (2%)
  kube-system                etcd-jesang-myung-9cf25ac51.mylabserver.com                       0 (0%)        0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-apiserver-jesang-myung-9cf25ac51.mylabserver.com             250m (12%)    0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-controller-manager-jesang-myung-9cf25ac51.mylabserver.com    200m (10%)    0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-flannel-ds-bss69                                             0 (0%)        0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-proxy-w6wmd                                                  0 (0%)        0 (0%)      0 (0%)           0 (0%)
  kube-system                kube-scheduler-jesang-myung-9cf25ac51.mylabserver.com             100m (5%)     0 (0%)      0 (0%)           0 (0%)
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource  Requests    Limits
  --------  --------    ------
  cpu       750m (37%)  0 (0%)
  memory    140Mi (1%)  340Mi (4%)
Events:     <none>
```

```
user@jesang-myung-9cf25ac51:~/template$ k taint node jesang-myung-9cf25ac51.mylabserver.com node-role.kubernetes.io/master-
node/jesang-myung-9cf25ac51.mylabserver.com untainted
```

```
user@jesang-myung-9cf25ac51:~/template$ k taint node jesang-myung-9cf25ac51.mylabserver.com node-role.kubernetes.io=master:NoSchedule
node/jesang-myung-9cf25ac51.mylabserver.com tainted
```

## Lecture: Manually Scheduling Pods



## Lecture: Upgrading Kubernetes Components
`deploy-for-upgrade.yaml`

`apt install -y kubelet="1.11.1-00" kubectl="1.11.1-00" kubeadm="1.11.1-00"`

```
user@jesang-myung-9cf25ac56:~/templete$ k get no
NAME                                     STATUS    ROLES     AGE       VERSION
jesang-myung-9cf25ac53.mylabserver.com   Ready     <none>    2m        v1.11.1
jesang-myung-9cf25ac54.mylabserver.com   Ready     <none>    2m        v1.11.1
jesang-myung-9cf25ac55.mylabserver.com   Ready     <none>    12m       v1.11.1
jesang-myung-9cf25ac56.mylabserver.com   Ready     master    25m       v1.11.1
```

`sudo apt upgrade kubeadm`
```
user@jesang-myung-9cf25ac56:~/templete$ sudo kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"11", GitVersion:"v1.11.3", GitCommit:"a4529464e4629c21224b3d52edfe0ea91b072862", GitTreeState:"clean", BuildDate:"2018-09-09T17:59:42Z", GoVersion:"go1.10.3", Compiler:"gc", Platform:"linux/amd64"}
```

```
user@jesang-myung-9cf25ac56:~/templete$ k get no
NAME                                     STATUS    ROLES     AGE       VERSION
jesang-myung-9cf25ac53.mylabserver.com   Ready     <none>    13m       v1.11.1
jesang-myung-9cf25ac54.mylabserver.com   Ready     <none>    14m       v1.11.1
jesang-myung-9cf25ac55.mylabserver.com   Ready     <none>    24m       v1.11.1
jesang-myung-9cf25ac56.mylabserver.com   Ready     master    36m       v1.11.3
user@jesang-myung-9cf25ac56:~/templete$ sudo kubeadm upgrade plan
[preflight] Running pre-flight checks.
[upgrade] Making sure the cluster is healthy:
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.11.3
[upgrade/versions] kubeadm version: v1.11.3
[upgrade/versions] Latest stable version: v1.11.3
[upgrade/versions] Latest version in the v1.11 series: v1.11.3

Awesome, you're up-to-date! Enjoy!
```
```
user@jesang-myung-9cf25ac56:~/templete$ sudo kubeadm upgrade apply v1.11.3
[preflight] Running pre-flight checks.
[upgrade] Making sure the cluster is healthy:
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[upgrade/apply] Respecting the --cri-socket flag that is set with higher priority than the config file.
[upgrade/version] You have chosen to change the cluster version to "v1.11.3"
[upgrade/versions] Cluster version: v1.11.3
[upgrade/versions] kubeadm version: v1.11.3
[upgrade/confirm] Are you sure you want to proceed with the upgrade? [y/N]: y
[upgrade/prepull] Will prepull images for components [kube-apiserver kube-controller-manager kube-scheduler etcd]
[upgrade/apply] Upgrading your Static Pod-hosted control plane to version "v1.11.3"...
Static pod: kube-apiserver-jesang-myung-9cf25ac56.mylabserver.com hash: 7291eb63908a4114b9ed63951b646554
Static pod: kube-controller-manager-jesang-myung-9cf25ac56.mylabserver.com hash: 7d9c84e45ae62e584f6f9a7136bc2941
Static pod: kube-scheduler-jesang-myung-9cf25ac56.mylabserver.com hash: 009228e74aef4d7babd7968782118d5e
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests300001497"
[controlplane] wrote Static Pod manifest for component kube-apiserver to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests300001497/kube-apiserver.yaml"
[controlplane] wrote Static Pod manifest for component kube-controller-manager to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests300001497/kube-controller-manager.yaml"
[controlplane] wrote Static Pod manifest for component kube-scheduler to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests300001497/kube-scheduler.yaml"
[certificates] Using the existing etcd/ca certificate and key.
[certificates] Using the existing apiserver-etcd-client certificate and key.
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-apiserver.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2018-09-24-14-58-00/kube-apiserver.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
```

```
user@jesang-myung-9cf25ac56:~/templete$ k drain jesang-myung-9cf25ac53.mylabserver.com --ignore-daemonsets
node/jesang-myung-9cf25ac53.mylabserver.com already cordoned
WARNING: Ignoring DaemonSet-managed pods: kube-flannel-ds-8jhdf, kube-proxy-x8vgf
```

```
user@jesang-myung-9cf25ac56:~/templete$ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Mon 2018-09-24 14:52:50 UTC; 18min ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 18576 (kubelet)
    Tasks: 15
   Memory: 70.7M
      CPU: 20.933s
   CGroup: /system.slice/kubelet.service
           └─18576 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --cgroup-driver=cgroupfs --cni
```

```
user@jesang-myung-9cf25ac56:~/templete$ k get no
NAME                                     STATUS                     ROLES     AGE       VERSION
jesang-myung-9cf25ac53.mylabserver.com   Ready,SchedulingDisabled   <none>    33m       v1.11.1
jesang-myung-9cf25ac54.mylabserver.com   Ready                      <none>    33m       v1.11.1
jesang-myung-9cf25ac55.mylabserver.com   Ready                      <none>    43m       v1.11.1
jesang-myung-9cf25ac56.mylabserver.com   Ready                      master    56m       v1.11.3
user@jesang-myung-9cf25ac56:~/templete$ k drain jesang-myung-9cf25ac56.mylabserver.com --ignore-daemonsets
node/jesang-myung-9cf25ac56.mylabserver.com cordoned
WARNING: Ignoring DaemonSet-managed pods: kube-flannel-ds-lsm8d, kube-proxy-8ljc8
pod/coredns-78fcdf6894-dr8ck evicted
pod/coredns-78fcdf6894-dq6bp evicted
user@jesang-myung-9cf25ac56:~/templete$ k get no
NAME                                     STATUS                     ROLES     AGE       VERSION
jesang-myung-9cf25ac53.mylabserver.com   Ready,SchedulingDisabled   <none>    33m       v1.11.1
jesang-myung-9cf25ac54.mylabserver.com   Ready                      <none>    34m       v1.11.1
jesang-myung-9cf25ac55.mylabserver.com   Ready                      <none>    44m       v1.11.1
jesang-myung-9cf25ac56.mylabserver.com   Ready,SchedulingDisabled   master    57m       v1.11.3
```

```
user@jesang-myung-9cf25ac56:~/templete$ k uncordon jesang-myung-9cf25ac53.mylabserver.com
node/jesang-myung-9cf25ac53.mylabserver.com uncordoned
user@jesang-myung-9cf25ac56:~/templete$ k get no
NAME                                     STATUS                     ROLES     AGE       VERSION
jesang-myung-9cf25ac53.mylabserver.com   Ready                      <none>    35m       v1.11.1
jesang-myung-9cf25ac54.mylabserver.com   Ready                      <none>    35m       v1.11.1
jesang-myung-9cf25ac55.mylabserver.com   Ready                      <none>    45m       v1.11.1
jesang-myung-9cf25ac56.mylabserver.com   Ready,SchedulingDisabled   master    58m       v1.11.3
```


```
user@jesang-myung-9cf25ac56:~/templete$ k get po -owide
NAME                     READY     STATUS    RESTARTS   AGE       IP           NODE                                     NOMINATED NODE
dummy-5bd654d46f-74rvc   1/1       Running   0          36m       10.244.2.2   jesang-myung-9cf25ac54.mylabserver.com   <none>
dummy-5bd654d46f-lchbm   1/1       Running   0          39m       10.244.1.2   jesang-myung-9cf25ac55.mylabserver.com   <none>
user@jesang-myung-9cf25ac56:~/templete$ k drain jesang-myung-9cf25ac54.mylabserver.com --ignore-daemonsets
node/jesang-myung-9cf25ac54.mylabserver.com cordoned
WARNING: Ignoring DaemonSet-managed pods: kube-flannel-ds-lj4r7, kube-proxy-7h9wj
pod/coredns-78fcdf6894-2fxgz evicted
pod/dummy-5bd654d46f-74rvc evicted
user@jesang-myung-9cf25ac56:~/templete$ k get po -owide
NAME                     READY     STATUS    RESTARTS   AGE       IP           NODE                                     NOMINATED NODE
dummy-5bd654d46f-lchbm   1/1       Running   0          41m       10.244.1.2   jesang-myung-9cf25ac55.mylabserver.com   <none>
dummy-5bd654d46f-nx5r5   1/1       Running   0          45s       10.244.3.3   jesang-myung-9cf25ac53.mylabserver.com   <none>
user@jesang-myung-9cf25ac56:~/templete$ k get no
NAME                                     STATUS                     ROLES     AGE       VERSION
jesang-myung-9cf25ac53.mylabserver.com   Ready                      <none>    39m       v1.11.1
jesang-myung-9cf25ac54.mylabserver.com   Ready,SchedulingDisabled   <none>    39m       v1.11.1
jesang-myung-9cf25ac55.mylabserver.com   Ready                      <none>    49m       v1.11.1
jesang-myung-9cf25ac56.mylabserver.com   Ready                      master    1h        v1.11.3
```

```
user@jesang-myung-9cf25ac56:~/templete$ ssh user@jesang-myung-9cf25ac54.mylabserver.com
The authenticity of host 'jesang-myung-9cf25ac54.mylabserver.com (34.202.158.53)' can't be established.
ECDSA key fingerprint is SHA256:GxL/FDdvPE+DYnmsDR3gRNrm4nq84FH96qDqPzUAXn8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'jesang-myung-9cf25ac54.mylabserver.com,34.202.158.53' (ECDSA) to the list of known hosts.
user@jesang-myung-9cf25ac54.mylabserver.com's password:
Welcome to Ubuntu 16.04.5 LTS (GNU/Linux 4.4.0-1066-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

21 packages can be updated.
0 updates are security updates.

New release '18.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Mon Sep 24 14:33:11 2018 from 1.227.70.130
user@jesang-myung-9cf25ac54:~$ sudo apt update
[sudo] password for user:
Hit:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial InRelease
Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]
Get:4 http://security.ubuntu.com/ubuntu xenial-security InRelease [107 kB]
Hit:5 https://packages.cloud.google.com/apt kubernetes-xenial InRelease
Fetched 323 kB in 0s (390 kB/s)
Reading package lists... Done
Building dependency tree
Reading state information... Done
15 packages can be upgraded. Run 'apt list --upgradable' to see them.
```

```
user@jesang-myung-9cf25ac54:~$
user@jesang-myung-9cf25ac54:~$ kubelet --version
Kubernetes v1.11.1
user@jesang-myung-9cf25ac54:~$ sudo apt upgrade kubelet
Reading package lists... Done
Building dependency tree
Reading state information... Done
Calculating upgrade... Done
The following NEW packages will be installed:
  linux-aws-headers-4.4.0-1067 linux-headers-4.4.0-1067-aws linux-headers-4.4.0-135 linux-headers-4.4.0-135-generic linux-image-4.4.0-1067-aws linux-image-4.4.0-135-generic
The following packages will be upgraded:
  binutils initramfs-tools initramfs-tools-bin initramfs-tools-core kubeadm kubectl kubelet linux-aws linux-headers-aws linux-headers-generic linux-headers-virtual linux-image-aws linux-image-virtual
  linux-libc-dev linux-virtual
15 upgraded, 6 newly installed, 0 to remove and 0 not upgraded.
Need to get 108 MB of archives.
After this operation, 281 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 initramfs-tools all 0.122ubuntu8.12 [8,628 B]
Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 initramfs-tools-core all 0.122ubuntu8.12 [44.9 kB]
Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 initramfs-tools-bin amd64 0.122ubuntu8.12 [9,726 B]
Get:4 http://us-east-1.ec2.archive.ub
...
update-initramfs: Generating /boot/initrd.img-4.4.0-1067-aws
W: mdadm: /etc/mdadm/mdadm.conf defines no arrays.
Processing triggers for libc-bin (2.23-0ubuntu10) ...
user@jesang-myung-9cf25ac54:~$ kubelet --version
Kubernetes v1.11.3
user@jesang-myung-9cf25ac54:~$ exit
logout
Connection to jesang-myung-9cf25ac54.mylabserver.com closed.
user@jesang-myung-9cf25ac56:~/templete$ k get no
NAME                                     STATUS                     ROLES     AGE       VERSION
jesang-myung-9cf25ac53.mylabserver.com   Ready                      <none>    45m       v1.11.1
jesang-myung-9cf25ac54.mylabserver.com   Ready,SchedulingDisabled   <none>    45m       v1.11.3
jesang-myung-9cf25ac55.mylabserver.com   Ready                      <none>    55m       v1.11.1
jesang-myung-9cf25ac56.mylabserver.com   Ready                      master    1h        v1.11.3
```

## Lecture: Upgrading the Underlying Operating System(s)
