#!/bin/sh 
export KUBECONFIG=/home/lab-user/install/auth/kubeconfig
sleep 30
NOTREADY=$(/usr/local/bin/oc get nodes |grep -c NotReady)

while [ $NOTREADY -gt 0 ]; do
        /usr/local/bin/oc get csr|grep Pending|awk '{print $1}'|xargs -i oc adm certificate approve {}
        sleep 30
        NOTREADY=$(/usr/local/bin/oc get nodes |grep -c NotReady)
done
