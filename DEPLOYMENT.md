# CreatorOS AI — Browser edition

A static, zero-server-cost deployment of the creator workspace. Open in a modern browser over HTTPS. Password-derived AES-GCM vault (PBKDF2 SHA-256, 600,000 iterations), encrypted localStorage metadata and IndexedDB asset blobs. This is browser-local encryption, not server authentication or cross-device cloud sync. The public repository contains no private creator content, credentials, database, or media.

To migrate local V1: open Settings, import its seed.json or exported workspace JSON, then reupload original MP4/MP3/cover/subtitle files through Asset library. JSON backup is plaintext and excludes binary files; store it privately. Import replaces metadata and deletes current uploaded blobs after confirmation. Clearing site data or forgetting the password can make data inaccessible. Do not store highly sensitive secrets. No live YouTube/Instagram analytics, automatic publishing or AI APIs; platform studios are links, metrics are manually entered. Cloud database and OAuth are a later migration.

Run with a static HTTPS host or localhost. Git-linked Vercel deployment uses the root HTML/CSS/JS and security headers. No dependencies or build step.
