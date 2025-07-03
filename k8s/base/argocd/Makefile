get-admin-password:
	kubectl get secret argocd-cluster -o jsonpath='{.data.admin\.password}' -n argocd | base64 -d
