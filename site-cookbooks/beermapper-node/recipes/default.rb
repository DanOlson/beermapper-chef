javascript_runtime node['beermapper-node']['version']

node_package 'ember-cli' do
  version node['beermapper-node']['ember-cli-version']
end

node_package 'bower'

link '/usr/bin/node' do
  to '/opt/nodejs-0.10.36/bin/node'
end

link '/usr/bin/npm' do
  to '/opt/nodejs-0.10.36/bin/npm'
end
