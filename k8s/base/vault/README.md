## Operations
### Initialization
```sh
kubectl exec vault-0 -n vault -- vault operator init > _dev/keys
kubectl exec vault-0 -n vault -- vault login "$(awk '/Root Token:/ { print $4}' _dev/keys)"
```

### Enable kv engine
```sh
kubectl exec vault-0 -n vault -- vault secrets enable -path=kv kv-v2
```

### Enable kubernetes auth and role
```sh
kubectl exec vault-0 -n vault -- vault auth enable -path=kubernetes kubernetes
kubectl exec vault-0 -n vault -- sh -c '
vault write auth/kubernetes/config \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host="https://${KUBERNETES_SERVICE_HOST}:${KUBERNETES_SERVICE_PORT_HTTPS}" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt'

kubectl exec vault-0 -n vault -- sh -c '
vault write auth/kubernetes/role/vault-role \
  audience=vault \
  bound_service_account_names=default \
  bound_service_account_namespaces=external-dns,cert-manager,tailscale-operator,argocd \
  policies=default \
  ttl=24h'
```

### Update default policy
```sh
kubectl exec vault-0 -n vault -- sh -c 'vault policy read default > /tmp/default-policy.hcl'
kubectl exec vault-0 -n vault -- sh -c 'cat >> /tmp/default-policy.hcl <<-EOF
# Allow access kv data
path "kv/data/*" {
  capabilities = ["read"]
}
path "kv/metadata/*" {
  capabilities = ["read"]
}
EOF'

kubectl exec vault-0 -n vault -- vault policy write default /tmp/default-policy.hcl
```

### Backup Secrets
```sh
kubectl exec vault-0 -n vault -- vault operator raft snapshot save /tmp/raft.snap
kubectl cp -n vault vault-0:/tmp/raft.snap _dev/raft.snap
```

### Restore Secrets
```sh
kubectl cp -n vault _dev/raft.snap vault-0:/tmp/raft.snap
kubectl exec vault-0 -n vault -- vault operator raft snapshot restore /tmp/raft.snap
```
