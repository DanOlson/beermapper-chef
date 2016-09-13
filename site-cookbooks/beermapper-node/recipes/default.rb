node_version = node['beermapper-node']['version']

javascript_runtime node_version

link '/usr/bin/node' do
  to "/opt/nodejs-#{node_version}/bin/node"
end

link '/usr/bin/npm' do
  to "/opt/nodejs-#{node_version}/bin/npm"
end

node_package 'ember-cli' do
  version node['beermapper-node']['ember-cli-version']
end

node_package 'bower'

link '/usr/local/lib/node_modules' do
  to "/opt/nodejs-#{node_version}/lib/node_modules"
end

link '/usr/local/bin/bower' do
  to "/usr/local/lib/node_modules/bower/bin/bower"
end

link '/usr/local/bin/ember' do
  to "/usr/local/lib/node_modules/ember-cli/bin/ember"
end
