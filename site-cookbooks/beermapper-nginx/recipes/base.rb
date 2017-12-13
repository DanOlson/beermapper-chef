%w(libcurl4-openssl-dev libpcre3 libpcre3-dev).each do |pkg|
  package pkg
end

bash 'install Passenger' do
  code <<-EOF
    source #{node['beermapper-nginx']['rvm']['rvm_shell']}
    gem install passenger -v #{node['beermapper-nginx']['passenger']['version']}
  EOF

  regex = Regexp.escape("passenger (#{node['beermapper-nginx']['passenger']['version']})")
  not_if { `bash -c "source #{node['beermapper-nginx']['rvm']['rvm_shell']} && gem list"`.lines.grep(/^#{regex}/).count > 0 }
end

bash "Installing passenger nginx module and nginx from source" do
  code <<-EOF
  source #{node['beermapper-nginx']['rvm']['rvm_shell']}
  passenger-install-nginx-module --auto --prefix=/opt/nginx --auto-download --extra-configure-flags="\"#{node['beermapper-nginx']['nginx']['extra_configure_flags']}\""
  EOF
  user "root"
  not_if { File.exists? "/opt/nginx/sbin/nginx" }
end

template "/opt/nginx/conf/nginx.conf" do
  source "nginx.conf.erb"
  variables({
    ruby_version: node['beermapper-nginx']['ruby_version'],
    passenger: node['beermapper-nginx']['passenger'],
    nginx: node['beermapper-nginx']['nginx']
  })
  notifies :restart, 'service[nginx]'
end

directory '/opt/nginx/conf.d'

passenger_root = "/usr/local/rvm/gems/ruby-#{node['beermapper-nginx']['ruby_version']}/gems/passenger-#{node['beermapper-nginx']['passenger']['version']}"

template '/opt/nginx/conf.d/passenger.conf' do
  source 'passenger.conf.erb'
  variables({
    passenger_root: passenger_root,
    passenger_ruby: node['beermapper-nginx']['passenger']['ruby'],
    max_pool_size: node['beermapper-nginx']['passenger']['max_pool_size'],
    min_instances: node['beermapper-nginx']['passenger']['min_instances'],
    pool_idle_time: node['beermapper-nginx']['passenger']['pool_idle_time'],
    max_requests: node['beermapper-nginx']['passenger']['max_requests'],
    max_instances: node['beermapper-nginx']['passenger']['max_instances_per_app']
  })
  notifies :restart, 'service[nginx]'
end

# Install the nginx control script
cookbook_file "/etc/init.d/nginx" do
  source "nginx.initd"
  action :create
  mode 0755
end

# Add log rotation
cookbook_file "/etc/logrotate.d/nginx" do
  source "nginx.logrotate"
  action :create
end

directory "/opt/nginx/sites-enabled" do
  mode 0755
  action :create
  not_if { File.directory? "/opt/nginx/sites-enabled" }
end

directory "/opt/nginx/sites-available" do
  mode 0755
  action :create
  not_if { File.directory? "/opt/nginx/sites-available" }
end

systemd_unit 'nginx.service' do
  content <<-EOF
[Unit]
Description=A high performance web server and a reverse proxy server
After=network.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/opt/nginx/sbin/nginx -t -q -g 'daemon on; master_process on;'
ExecStart=/opt/nginx/sbin/nginx -g 'daemon on; master_process on;'
ExecReload=/opt/nginx/sbin/nginx -g 'daemon on; master_process on;' -s reload
ExecStop=-/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid
TimeoutStopSec=5
KillMode=mixed

[Install]
WantedBy=multi-user.target
  EOF

  action [:create, :enable]
end

# Set up service to run by default
service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable]
end
