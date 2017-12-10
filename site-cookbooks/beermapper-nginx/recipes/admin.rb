include_recipe 'beermapper-nginx::certbot'

domain_name = node['beermapper-nginx']['nginx']['evergreen_admin_domain_name']

directory certbot_well_known_path_for(domain_name) do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

certbot_self_signed_certificate domain_name

template '/opt/nginx/conf.d/admin.evergreenmenus.conf' do
  source 'admin.evergreenmenus.conf.erb'
  variables({
    evergreen_admin_domain_name: domain_name,
    rails_env: node['beermapper-nginx']['passenger']['rails_env'],
    server_root: node['beermapper-nginx']['nginx']['server_root'],
    webroot_dir: node['certbot']['webroot_dir']
  })
  notifies :restart, 'service[nginx]', :immediately
end

if node['beermapper-nginx']['letsencrypt']['enable']
  certbot_certificate domain_name do
    email 'admin@evergreenmenus.com'
    test node['beermapper-nginx']['letsencrypt']['use-acme-staging']
    allow_fail node['beermapper-nginx']['letsencrypt']['allow-fail']
    install_cron false # We do this in beermapper-nginx::certbot so we can get the command right
    notifies :restart, 'service[nginx]'
  end
end
