docker-compose \
--x-networking \
--x-network-driver=overlay \
--file docker-compose.yml \
--file docker-compose.override.yml \
up \
-d \
--no-color \
--force-recreate \
--no-recreate \
--no-build \
--timeout 10