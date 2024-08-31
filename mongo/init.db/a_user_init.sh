#!/bin/bash
set -e

# Ensure the database and user are created

# Wait for MongoDB to start
echo "Waiting for MongoDB to start..."
until mongosh --eval "print(\"waited for mongodb\")" > /dev/null 2>&1; do
  sleep 1
done

# Create the MongoDB user
echo "Creating MongoDB user..."
mongosh <<EOF
use ${MONGO_INITDB_DATABASE}
db.createUser({
  user: "${AURORA_USER}",
  pwd: "${AURORA_PWD}",
  roles: [{ role: "readWrite", db: "${MONGO_INITDB_DATABASE}" }]
});
EOF

echo "MongoDB user created successfully."
