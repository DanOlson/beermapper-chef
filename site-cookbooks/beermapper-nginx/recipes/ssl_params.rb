dhparam_file = node['beermapper-nginx']['nginx']['dhparam_file']

openssl_dhparam dhparam_file do
  key_length 2048
  generator 2
end

directory '/opt/nginx/snippets'

template '/opt/nginx/snippets/ssl-params.conf' do
  source 'ssl-params.conf.erb'
  variables dhparam_file: dhparam_file
  notifies :restart, 'service[nginx]'
end
