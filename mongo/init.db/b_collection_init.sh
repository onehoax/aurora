#!/bin/bash
set -e

# Create the mongo collection
echo -e "\n"
echo "############################## Creating mongo collection... ##############################"
echo -e "\n"
mongosh <<EOF

use admin;
db.auth("${MONGO_INITDB_ROOT_USERNAME}", "${MONGO_INITDB_ROOT_PASSWORD}");

use ${MONGO_INITDB_DATABASE};

db.createCollection("users");
db.users.createIndex({ document_id: 1 }, { unique: true });

EOF

echo -e "\n"
echo "############################## Mongo collection created successfully. ##############################"
echo -e "\n"
