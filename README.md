# opsworks_letsencrypt

Steps
- Configure Stack settings
- Add this cookbook/receipe to the appropriate layer in Opsworks
- Allow webserver (if running) to accept letsencrypt challenges (webroot or standalone)
- Issue certs
- Upload certs to app
- Create S3 buckets to backup certs (encrypted)
- Configure AWS manage-certs policy to allow access to S3 bucket
- Backup /etc/letsencrypt directory to S3
- If new server, download /etc/letsencrypt directory from s3
