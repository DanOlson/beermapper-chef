default['postgresql']['version']              = '9.4'
default['postgresql']['server']['packages']   = ['postgresql-9.4']
default['postgresql']['password']['postgres'] = 'anotsorandompassword'
default['postgresql']['dir']                  = '/var/lib/postgresql/9.4/main'
default['postgresql']['enable_pgdg_apt']      = true

default['beermapper-postgres']['database_host'] = 'localhost'
default['beermapper-postgres']['database_port'] = 5432
default['beermapper-postgres']['database_name'] = 'on_tap_production'
default['beermapper-postgres']['database_user']['username'] = ''
default['beermapper-postgres']['database_user']['password'] = ''
