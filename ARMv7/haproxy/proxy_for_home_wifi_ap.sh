docker run -dit -p 8001:8001 --name proxy_for_home_wifi_ap -v "$(pwd)":/data/config haproxy /bin/bash
docker exec proxy_for_home_wifi_ap /bin/sh -c "cat /data/config/proxy_for_home_wifi_ap.cfg > /usr/local/etc/haproxy/haproxy.cfg"
docker exec proxy_for_home_wifi_ap haproxy -f /usr/local/etc/haproxy/haproxy.cfg
