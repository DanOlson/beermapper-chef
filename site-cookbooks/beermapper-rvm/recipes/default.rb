gpg_key = node['beermapper-rvm']['gpg_key']
gpg_keyserver = node['beermapper-rvm']['gpg_keyserver']

execute 'trust mpapis public key' do
  environment ({"HOME" => "/root", "USER" => "root"})
  user 'root'
  command "`which gpg2 || which gpg` --keyserver #{gpg_keyserver} --recv-keys #{gpg_key}"
  only_if 'which gpg2 || which gpg'
  not_if { gpg_key.empty? }
  not_if "`which gpg2 || which gpg` --list-keys | fgrep #{gpg_key}"
end

include_recipe 'rvm::system'

rvm_default_ruby 'ruby-2.3.0'

rvm_gem 'bundler' do
  version '1.12.5'
end
