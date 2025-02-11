%w(
  /var/apps
  /var/apps/beermapper
  /var/apps/beermapper/releases
  /var/apps/beermapper/shared
  /var/apps/beermapper/shared/assets
  /var/apps/beermapper/shared/bundle
  /var/apps/beermapper/shared/config
  /var/apps/beermapper/shared/log
  /var/apps/beermapper/shared/pids
  /var/apps/beermapper/shared/system
).each do |dir|
  directory dir do
    mode 0775
    owner 'deploy'
    group 'deploy'
  end
end

template '/var/apps/beermapper/shared/config/database.yml' do
  source 'database.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode 0600
  variables({
    rails_env: node['beermapper']['rails_env'],
    adapter: node['beermapper']['database']['adapter'],
    user: node['beermapper-postgres']['database_user']['username'],
    password: node['beermapper-postgres']['database_user']['password'],
    db_name: node['beermapper-postgres']['database_name'],
    pool: node['beermapper']['database']['pool'],
    timeout: node['beermapper']['database']['timeout']
  })
end

template '/var/apps/beermapper/shared/config/app_config.yml' do
  source 'app_config.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode 0600
  variables({
    rails_env: node['beermapper']['rails_env'],
    api_key: node['beermapper']['app_config']['api_key'],
    secret_token: node['beermapper']['app_config']['secret_token'],
    mailgun_api_key: node['beermapper']['app_config']['mailgun_api_key'],
    mailgun_domain: node['beermapper']['app_config']['mailgun_domain'],
    google_client_id: node['beermapper']['app_config']['google_client_id'],
    google_client_secret: node['beermapper']['app_config']['google_client_secret'],
    facebook_client_id: node['beermapper']['app_config']['facebook_client_id'],
    facebook_client_secret: node['beermapper']['app_config']['facebook_client_secret'],
    stripe_pub_key: node['beermapper']['app_config']['stripe_pub_key'],
    stripe_api_key: node['beermapper']['app_config']['stripe_api_key'],
    stripe_webhook_secret: node['beermapper']['app_config']['stripe_webhook_secret'],
    web_menu_host: node['beermapper-nginx']['nginx']['evergreen_cdn_domain_name'],
    aws_access_key_id: node['beermapper']['app_config']['aws_access_key_id'],
    aws_secret_access_key: node['beermapper']['app_config']['aws_secret_access_key']
  })
end
