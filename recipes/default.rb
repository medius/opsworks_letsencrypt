execute 'wget-cert-software' do
  command "curl https://get.acme.sh | sh -s #{node[:letsencrypt][:email]}"
  action :run
end

template "#{node[:letsencrypt][:scripts_path]}/get_certs.sh" do
  source 'get_certs.sh.erb'
  owner 'root'
  group 'root'
  mode 0744

  variables(
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
    main_ssl_domain: node[:letsencrypt][:ssl_domains].first
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
