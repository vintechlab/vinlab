cluster.create:
	kind create cluster --name vinlab --config kind-config.yaml

cluster.verify:
	kubectl get nodes
	kubectl get pods -A

cluster.label-nodes:
	kubectl label node vinlab-worker node-role.kubernetes.io/worker=true
	kubectl label node vinlab-worker2 node-role.kubernetes.io/worker=true

install.calico:
	kustomize build network | kubectl apply -f - --server-side --validate=false --force-conflicts

install.openebs:
	kustomize build storage | kubectl apply -f - --server-side --validate=false --force-conflicts

verify.calico:
	watch "kubectl get pods -l k8s-app=calico-node -A"

verify.openebs:
	watch "kubectl get pods -l 'name in (openebs-ndm,openebs-localpv-provisioner)' -A"
