# Migration: create_contact_requests
# Created: 2026-09-30 18:35:01
#
# Runs on the default connection. To target another one, uncomment this —
# then `soli db:migrate up` places it correctly with no --connection flag:
#
# connection "legacy"

def up(db) -> Any
  db.create_collection("contact_requests")
end

def down(db) -> Any
  db.drop_collection("contact_requests")
end
