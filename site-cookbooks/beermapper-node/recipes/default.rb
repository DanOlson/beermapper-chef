node_version = node['beermapper-node']['version']

javascript_runtime node_version

link '/usr/bin/node' do
  to "/opt/nodejs-#{node_version}/bin/node"
end

link '/usr/bin/npm' do
  to "/opt/nodejs-#{node_version}/bin/npm"
end

link '/usr/local/lib/node_modules' do
  to "/opt/nodejs-#{node_version}/lib/node_modules"
end
