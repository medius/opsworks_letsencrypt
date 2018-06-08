default[:letsencrypt][:ppa_path] = 'ppa:certbot/certbot'
default[:letsencrypt][:config_dir] = '/etc/letsencrypt'
default[:letsencrypt][:cert_name] = 'example.com'
default[:letsencrypt][:webroot_path] = '/var/www/html/'
default[:letsencrypt][:standalone_host] = '127.0.0.1'
default[:letsencrypt][:standalone_port] = '80'
default[:letsencrypt][:webroot_mode] = true # false => standalone mode

default[:letsencrypt][:ssl_domains] = ['example.com', 'www.example.com']

default[:letsencrypt][:email] = 'abc@example.com' # Letsencrypt account email

default[:letsencrypt][:opsworks_region] = 'us-east-1'

# Backup certs in S3
default[:letsencrypt][:s3_backup_region] = 'us-east-1'
default[:letsencrypt][:s3_backup_bucket] = 'certs-bucket'

default[:letsencrypt][:scripts_path] = '/home/ubuntu'
