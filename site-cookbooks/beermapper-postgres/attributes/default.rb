default['postgresql']['version'] = '9.5'
default['postgresql']['dir'] = '/etc/postgresql/9.5/main'
default['postgresql']['server']['service_name'] = 'postgresql'
default['postgresql']['client']['packages'] = ['postgresql-client-9.5', 'libpq-dev']
default['postgresql']['server']['packages'] = ['postgresql-9.5']
default['postgresql']['contrib']['packages'] = ['postgresql-contrib-9.5']
default['postgresql']['password']['postgres'] = 'anotsorandompassword'
default['postgresql']['dir']                  = '/var/lib/postgresql/9.5/main'
default['postgresql']['enable_pgdg_apt']      = true
default['postgresql']['pg_gem']['version']    = '0.21.0'

default['beermapper-postgres']['database_host'] = 'localhost'
default['beermapper-postgres']['database_port'] = 5432
default['beermapper-postgres']['database_name'] = 'on_tap_production'
default['beermapper-postgres']['database_user']['username'] = ''
default['beermapper-postgres']['database_user']['password'] = ''
