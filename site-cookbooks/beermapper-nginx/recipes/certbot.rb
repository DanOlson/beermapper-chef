apt_package 'software-properties-common'
apt_repository 'certbot' do
  uri 'ppa:certbot/certbot'
end
apt_package 'certbot'

directory node["certbot"]["working_dir"] do
  owner "root"
  group "root"
  mode 0755
  recursive true

  action :create
end

cron "renew letsencrypt certificates" do
  time :daily
  user 'root'
  command '/usr/bin/certbot renew --deploy-hook "/etc/init.d/nginx reload"'
  action :create
end

include_recipe 'beermapper-nginx::ssl_params'
