#!/bin/bash
echo "Starting replica set initialize"
until mongosh --host configs1 --eval "print(\"waited for connection\")"
do
    sleep 20
done
echo "Connection finished"
echo "Creating replica set"
mongosh --host configs1 <<EOF
rs.initiate(
  {
    _id : 'cfgrs',
    configsvr: true,
    members: [
      { _id : 0, host : "configs1:27017" , priority: 3 },
      { _id : 1, host : "configs2:27017" , priority: 2 },
      { _id : 2, host : "configs3:27017" , priority: 1 },
    ]
  }
)
EOF