apply-crd:
	kustomize build --enable-helm | kubectl apply --server-side=true --force-conflicts -f-
