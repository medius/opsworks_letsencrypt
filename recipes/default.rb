execute "wget-certbot" do
  command "wget https://dl.eff.org/certbot-auto"
  action :run
end

execute "mv-certbot" do
  command "mv certbot-auto #{node[:letsencrypt][:scripts_path]}/certbot-auto"
  action :run
end

execute "chmod-certbot" do
  command "chmod 0755 #{node[:letsencrypt][:scripts_path]}/certbot-auto"
  action :run
end

template "#{node[:letsencrypt][:scripts_path]}/certbot.sh" do
  source 'certbot.sh.erb'
  owner 'root'
  group 'root'
  mode 0744

  variables(
    email: node[:letsencrypt][:email],
    ssl_domains: node[:letsencrypt][:ssl_domains]
  )
end

template "#{node[:letsencrypt][:scripts_path]}/cert_upload.rb" do
  source 'cert_upload.rb.erb'
  owner 'root'
  group 'root'
  mode 0744

  variables(
    stack_id: node[:opsworks][:stack][:id],
    opsworks_region: node[:letsencrypt][:opsworks_region],
    ssl_domains: node[:letsencrypt][:ssl_domains]
  )
end

template "#{node[:letsencrypt][:scripts_path]}/backup_to_s3.rb" do
  source 'backup_to_s3.sh.erb'
  owner 'root'
  group 'root'
  mode 0744
end

template "#{node[:letsencrypt][:scripts_path]}/download_from_s3.rb" do
  source 'download_from_s3.sh.erb'
  owner 'root'
  group 'root'
  mode 0744
end
