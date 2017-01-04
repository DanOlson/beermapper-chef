template '/opt/nginx/conf.d/admin.beermapper.conf' do
  source 'admin.beermapper.conf.erb'
  variables({
    beermapper_admin_domain_name: node['beermapper-nginx']['nginx']['beermapper_admin_domain_name'],
    rails_env: node['beermapper-nginx']['passenger']['rails_env']
  })
  notifies :restart, 'service[nginx]'
end
