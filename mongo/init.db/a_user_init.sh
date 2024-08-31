#!/bin/bash
set -e

# Wait for MongoDB to start
echo -e "\n"
echo "############################## Waiting for MongoDB to start... ##############################"
echo -e "\n"

# The primary purpose of running mongosh --eval "print(\"waited for mongodb\")" is not about the output itself,
# but rather to check if mongosh can successfully connect to the MongoDB server.
# The actual JavaScript command (print("waited for mongodb")) is just a placeholder to have something executed once the connection is made.

# `print("waited for mongodb")` is just a simple, benign command used to validate the connection. 
# You could technically replace it with any # other MongoDB command (like db.runCommand({ping: 1})), but using print is minimal and has no side effects.

# The real purpose here is to loop until mongosh can successfully connect to MongoDB, at which point the script knows MongoDB is ready.
# The command's output being discarded is just to prevent unnecessary messages in the logs or terminal.
until mongosh --eval "print(\"waited for mongodb\")" > /dev/null 2>&1; do
  sleep 1
done

# Create the mongo user
echo -e "\n"
echo "############################## Creating mongo user... ##############################"
echo -e "\n"
mongosh <<EOF

use ${MONGO_INITDB_DATABASE};

db.createUser({
  user: "${AURORA_USER}",
  pwd: "${AURORA_PWD}",
  roles: [
    { 
      role: "readWrite", 
      db: "${MONGO_INITDB_DATABASE}" 
    }
  ]
});

EOF

echo -e "\n"
echo "############################## Mongo user created successfully. ##############################"
echo -e "\n"
