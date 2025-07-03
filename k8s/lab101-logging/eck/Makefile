get-password:
	kubectl get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
