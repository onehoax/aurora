/*
===============================================================
======================= Collections ===========================
===============================================================
*/

// ==================== Permissions ========================

// db.createCollection("permissions");

// ======================= Roles ===========================

// db.createCollection("roles");

// ======================= Users ===========================

db.createCollection("users", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "User Object Validation",
      required: ["document_id", "username"],
      properties: {
        document_id: {
          bsonType: "string",
          description: "'document_id' must be a string and is required",
        },
        username: {
          bsonType: "string",
          description: "'username' must be a string and is required",
        },
      },
    },
  },
});
db.users.createIndex({ document_id: 1 }, { unique: true });
