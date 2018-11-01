source "https://api.berkshelf.com"

cookbook 'apt'
cookbook 'postgresql',       '~> 6.1.1'
cookbook 'database',         '~> 5.1.2'
cookbook 'locale',           '~> 1.1.0'
cookbook 'rvm',  github: 'fnichol/chef-rvm'
cookbook 'certbot',          '~> 0.6.0', github: 'DanOlson/chef-certbot', branch: 'adjust-symlinks-and-cron'
cookbook 'ufw',              '~> 3.1.0'
cookbook 'imagemagick',      '~> 0.2.3'

cookbook 'beermapper',             path: 'site-cookbooks/beermapper'
cookbook 'beermapper-users',       path: 'site-cookbooks/beermapper-users'
cookbook 'beermapper-rvm',         path: 'site-cookbooks/beermapper-rvm'
cookbook 'beermapper-postgres',    path: 'site-cookbooks/beermapper-postgres'
cookbook 'beermapper-nginx',       path: 'site-cookbooks/beermapper-nginx'
cookbook 'beermapper-firewall',    path: 'site-cookbooks/beermapper-firewall'
cookbook 'beermapper-imagemagick', path: 'site-cookbooks/beermapper-imagemagick'
