include_recipe 'certbot'
include_recipe 'beermapper-nginx::ssl_params'

domain_name = node['beermapper-nginx']['nginx']['beermapper_domain_name']

bash 'Adding beermapper-api.com to /etc/hosts' do
  code 'echo "127.0.0.1 beermapper-api.com" >> /etc/hosts'
  not_if { File.read('/etc/hosts').match /beermapper-api\.com/ }
end

certbot_self_signed_certificate domain_name

template '/opt/nginx/conf.d/beermapper.conf' do
  source 'beermapper.conf.erb'
  variables({
    beermapper_domain_name: domain_name,
    rails_env: node['beermapper-nginx']['passenger']['rails_env'],
    server_root: node['beermapper-nginx']['nginx']['server_root']
  })
  notifies :restart, 'service[nginx]', :immediately
end

if node['beermapper-nginx']['letsencrypt']['enable']
  certbot_certificate domain_name do
    email 'admin@beermapper.com'
    test node['beermapper-nginx']['letsencrypt']['use-acme-staging']
    allow_fail node['beermapper-nginx']['letsencrypt']['allow-fail']
    notifies :restart, 'service[nginx]'
  end
end
