
# Ruby & RVM
default['beermapper-nginx']['ruby_version'] = "2.3.0"
default['beermapper-nginx']['rvm']['rvm_shell'] = '/etc/profile.d/rvm.sh'

# Nginx
default['beermapper-nginx']['nginx']['extra_configure_flags'] = "--with-http_gzip_static_module"
default['beermapper-nginx']['nginx']['worker_processes']      = 2
default['beermapper-nginx']['nginx']['user']                  = 'www-data'
default['beermapper-nginx']['nginx']['access_log']            = '/opt/nginx/logs/access.log'
default['beermapper-nginx']['nginx']['error_log']             = '/opt/nginx/logs/error.log'
default['beermapper-nginx']['nginx']['beermapper_admin_domain_name'] = 'admin.evergreenmenus.com'
default['beermapper-nginx']['nginx']['beermapper_cdn_domain_name'] = 'cdn.evergreenmenus.com'
default['beermapper-nginx']['nginx']['server_root'] = '/var/apps/beermapper/current/public'
default['beermapper-nginx']['nginx']['dhparam_file'] = '/etc/ssl/certs/dhparam.pem'

default['beermapper-nginx']['letsencrypt']['enable'] = false
default['beermapper-nginx']['letsencrypt']['use-acme-staging'] = false
default['beermapper-nginx']['letsencrypt']['allow-fail'] = false

# Passenger
default['beermapper-nginx']['passenger']['version']               = '5.0.30'
default['beermapper-nginx']['passenger']['ruby']                  = '/usr/local/rvm/wrappers/default/ruby'
default['beermapper-nginx']['passenger']['max_pool_size']         = 6
default['beermapper-nginx']['passenger']['min_instances']         = 1
default['beermapper-nginx']['passenger']['pool_idle_time']        = 300
default['beermapper-nginx']['passenger']['max_instances_per_app'] = 0
default['beermapper-nginx']['passenger']['max_requests']          = 0
default['beermapper-nginx']['passenger']['max_instances_per_app'] = 0
default['beermapper-nginx']['passenger']['rails_env']             = 'production'

# a list of URLs to pre-start.
default['beermapper-nginx']['passenger']['pre_start'] = []

# Certbot
default['certbot']['executable'] = '/usr/bin/certbot'
