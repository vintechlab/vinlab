CLUSTER_NAME := vinlab

cluster.create:
	kind create cluster --config kind-config.yaml --name $(CLUSTER_NAME)

cluster.delete:
	kind delete cluster --name $(CLUSTER_NAME)

cluster.label-nodes:
	kubectl label node $(CLUSTER_NAME)-worker node-role.kubernetes.io/worker=true
	kubectl label node $(CLUSTER_NAME)-worker2 node-role.kubernetes.io/worker=true

cluster.get-nodes:
	kubectl get nodes
