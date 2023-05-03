ALTER TABLE atlas_app.merchant ADD COLUMN signing_public_key text;
ALTER TABLE atlas_app.merchant ADD COLUMN signature_expiry int;

-- test data for dev
UPDATE atlas_app.merchant
SET signing_public_key = 'LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUF4S2pqQ1NEREYzcFFOcDlOUFVGcApZTDZvUTVTNUtwNE9aeU1Pd0d6c21YOEZyTisveGplSkV2QWQxU041UHdIcldhT3VrKy8vNGZrUytVaU95cFBUCnVBSEdkSXYrcmRZaVd3TUZKUzVRWWRpcEpCQW5pWnNnZVZSazhUcnNncmcraVR4b2hZRWpOdjMwZWsrRWpYS1UKemtOekNleW5XQ2VoY2RvY1IvVnZScFZsOExSb1pGVGlDTmU1UWtycTIyM2tkdDJoY2hubE9iZjltTHpvY0x5cQpKZ0E3N1VGZUJQb2V0aEp3S0FWUmVBeHI4SG1rUnJJMXVqYllMbHN5azk0SG1nYlpSTWFiUTJDcXVFUDYxYlI1Cm1hTit5RjF0TC9mRGRXY29rN3lQeTA1TnNkdkR1T29KYTluREFtcXQzUmdCbjlxU1QyMTZmVjR4a3pjdWRJQ2YKd1FJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==',
    signature_expiry = 31536000;

ALTER TABLE atlas_app.merchant ALTER COLUMN signing_public_key SET NOT NULL;
ALTER TABLE atlas_app.merchant ALTER COLUMN signature_expiry SET NOT NULL;