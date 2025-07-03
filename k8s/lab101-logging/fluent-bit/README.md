```sh
docker exec vinlab-control-plane sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf
docker exec vinlab-control-plane journalctl --flush
docker exec vinlab-control-plane systemctl restart systemd-journald

docker exec vinlab-worker sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf
docker exec vinlab-worker journalctl --flush
docker exec vinlab-worker systemctl restart systemd-journald

docker exec vinlab-worker2 sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf
docker exec vinlab-worker2 journalctl --flush
docker exec vinlab-worker2 systemctl restart systemd-journald
```
