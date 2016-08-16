username = node['beermapper-users']['deploy-user']
home_dir = "/home/#{username}"

user username do
  home home_dir
  shell '/bin/bash'
  supports manage_home: true
end

execute "generate ssh keys for #{username}." do
  user username
  creates "#{home_dir}/.ssh/id_rsa.pub"
  command %(ssh-keygen -t rsa -q -f #{home_dir}/.ssh/id_rsa -P "")
  not_if { File.exists?("#{home_dir}/.ssh/id_rsa.pub") }
end

template "#{home_dir}/.ssh/authorized_keys" do
  source 'authorized_keys.erb'
  owner username
  group username
  mode 00644
  variables({
    authorized_keys: Array(data_bag_item('authorized_keys', 'dan'))
  })
end
