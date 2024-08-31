#!/bin/bash
set -e

# Insert some initial values
echo -e "\n"
echo "############################## Inserting initial values... ##############################"
echo -e "\n"
mongosh <<EOF

use ${MONGO_INITDB_DATABASE};

db.users.insertMany([
  { 
    document_id: "12345", 
    username: "andres",
    inserted_at: new Date(),
    updated_at: new Date()
  },
  { 
    document_id: "67890", 
    username: "nela",
    inserted_at: new Date(),
    updated_at: new Date()
  }
]);

EOF

echo -e "\n"
echo "############################## Inserted initial values successfully. ##############################"
echo -e "\n"