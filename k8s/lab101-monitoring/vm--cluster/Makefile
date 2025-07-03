NAMESPACE=lab101-metrics

get-password:
	kubectl get secret -n $(NAMESPACE) vmuser-vmuser-anyone -o jsonpath="{.data.password}" | base64 --decode
