template '/opt/nginx/conf.d/beermapper.conf' do
  source 'beermapper.conf.erb'
  variables({
    beermapper_domain_name: node['beermapper-nginx']['nginx']['beermapper_domain_name'],
    rails_env: node['beermapper-nginx']['passenger']['rails_env']
  })
  notifies :restart, 'service[nginx]'
end

bash 'Adding beermapper-api.com to /etc/hosts' do
  code 'echo "127.0.0.1 beermapper-api.com" >> /etc/hosts'
  not_if { File.read('/etc/hosts').match /beermapper-api\.com/ }
end
