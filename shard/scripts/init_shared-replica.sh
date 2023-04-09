#!/bin/bash
echo "Starting replica set initialize"
until mongosh --host shards1 --eval "print(\"waited for connection\")"
do
    sleep 20
done
echo "Connection finished"
echo "Creating replica set"
mongosh --host shards1 <<EOF
rs.initiate(
  {
    _id : 'shard1rs',
    members: [
      { _id : 0, host : "shards1:27017" , priority: 3 },
      { _id : 1, host : "shard1s2:27017" , priority: 2 },
      { _id : 2, host : "shard1s3:27017" , priority: 1 },
    ]
  }
)
EOF