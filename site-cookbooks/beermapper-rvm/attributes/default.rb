gpg_key    = '409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
gpg_server = 'hkp://pool.sks-keyservers.net'

default['rvm']['default_ruby']  = 'ruby-2.3.0'
default['rvm']['group_users']   = ['root', 'deploy']
default['rvm']['gpg']           = {} # this apparently needs to be defined
default['rvm']['gpg_key']       = gpg_key
default['rvm']['gpg_keyserver'] = gpg_server
default['rvm']['global_gems']   = [
  { name: "bundler" },
  { name: "rake" }
]

default['beermapper-rvm']['gpg_key']       = gpg_key
default['beermapper-rvm']['gpg_keyserver'] = gpg_server
