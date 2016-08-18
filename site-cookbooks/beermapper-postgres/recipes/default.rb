include_recipe 'postgresql::server'
include_recipe 'postgresql::ruby'
include_recipe 'database::postgresql'

connection_info = {
  host:      node['beermapper-postgres']['database_host'],
  port:      node['beermapper-postgres']['database_port'],
  username: 'postgres',
  password:  node['postgresql']['password']['postgres']
}

db_user = node['beermapper-postgres']['database_user']['username']
db_name = node['beermapper-postgres']['database_name']

postgresql_database db_name do
  connection connection_info
  encoding 'UTF8'
  action :create
end

postgresql_database_user db_user do
  connection connection_info
  password node['beermapper-postgres']['database_user']['password']
  privileges [:all]
  database_name db_name
  action [:create, :grant]
end
