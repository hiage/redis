# run this for loop to create each redis container configuration file
for port in $(seq 1 6); do
  mkdir -p redis/node-${port}/conf
  touch redis/node-${port}/conf/redis.conf
  cat << EOF >redis/node-${port}/conf/redis.conf
# Network
port 6379
bind 0.0.0.0
tcp-backlog 65535

# Cluster
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 10.3.6.2${port}
cluster-announce-port 6379
cluster-announce-bus-port 16379
cluster-require-full-coverage no
cluster-migration-barrier 1

# Memory Management
maxmemory 10gb  # Limit memory usage to 10 GB
maxmemory-policy allkeys-lru  # Eviction policy
appendonly yes
appendfsync everysec  # Sync append-only file every second

# Replication
replica-read-only yes
replica-serve-stale-data yes

# Performance Tuning
tcp-keepalive 300  # Keep connections alive
timeout 0  # Disable connection timeouts
protected-mode no
always-show-logo yes

# Limits
maxclients 20000

# Latency Optimization
latency-monitor-threshold 100  # Monitor operations taking longer than 100 ms

# Advanced Memory Tuning
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-entries 512
list-max-ziplist-value 64
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
set-max-intset-entries 512

# Disable swap to prevent latency issues
no-appendfsync-on-rewrite yes
lazyfree-lazy-eviction yes
lazyfree-lazy-expire yes
lazyfree-lazy-server-del yes


EOF
done