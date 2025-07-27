# kubectl aliases
alias kget="k get"
alias kdesc="k describe"
alias kyaml="k get -oyaml"

# Kustomize aliases
alias kusbuild='kustomize build --enable-helm'
alias kusdiff='kusbuild | k diff -f-'
alias kusapply="kusbuild | k apply -f-"
alias kusdelete="kusbuild | k delete -f-"
alias kuscreate="kusbuild | k create -f-"
alias kusreplace="kusbuild | k replace -f-"

function kgetresources() {
    local namespace="${1:-}"
    local namespace_flag=""
    if [[ -n "$namespace" ]]; then
        namespace_flag="-n $namespace"
    fi

    echo "Fetching Kubernetes resources..."
    kubectl api-resources --verbs=list --namespaced -o name | \
    while read -r resource; do
        echo -n "Checking $resource... "
        kubectl get $resource $namespace_flag --ignore-not-found --no-headers 2>/dev/null | \
        while read -r line; do
            if [[ -n "$line" ]]; then
                echo "$resource: $line"
            fi
        done
    done | sort | column -t -s ':'
}
