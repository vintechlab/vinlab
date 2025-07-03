```sh
# authen
PASSWORD=$(kubectl get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')


# create user
kubectl exec -it elasticsearch-es-master-0 -- curl -XPOST -uelastic:${PASSWORD} localhost:9200/_security/user/fluent-bit -H "Content-Type: application/json" -d '{"password": "fluent-bit", "roles": ["superuser"]}'

# delete user
kubectl exec -it elasticsearch-es-master-0 -- curl -XDELETE -uelastic:${PASSWORD} localhost:9200/_security/user/fluent-bit
```


## Built-in roles
Ref: https://www.elastic.co/docs/deploy-manage/users-roles/cluster-or-deployment-auth/built-in-roles
