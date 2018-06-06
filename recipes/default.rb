package 'software-properties-common' do
  action :install
end

execute "add-ppa-update" do
  command "add-apt-repository #{node[:letsencrypt][:ppa_path]} && apt-get update -y"
  action :run
end

package "certbot" do
  retries 3
  retry_delay 5

  action  :install
end

chef_gem 'aws-sdk-opsworks' do
  action :install
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
