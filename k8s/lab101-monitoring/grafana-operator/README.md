#

```sh
helm template -n lab101-grafana-operator --include-crds \
  grafana-operator \
  oci://ghcr.io/grafana/helm-charts/grafana-operator \
  --version v5.15.0 > base0.yaml
```
