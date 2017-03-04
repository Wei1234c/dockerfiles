#!/bin/bash
 
# Start containers
docker run -dit -p 6379:6379  --name=redis -v /data:/data wei1234c/redis_armv7 
