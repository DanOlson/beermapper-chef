describe 'nginx installation' do
  describe file('/etc/hosts') do
    its(:content){ is_expected.to match /127.0.0.1 beermapper-api.com/ }
  end

  describe file('/opt/nginx') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
  end

  describe file('/opt/nginx/conf') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
  end

  describe file('/opt/nginx/conf.d') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
  end

  describe file('/opt/nginx/conf/nginx.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    its(:content) { is_expected.to include 'include /opt/nginx/conf.d/*.conf;' }
  end

  describe file('/opt/nginx/conf.d/passenger.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }
  end

  describe file('/var/www/letsencrypt') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
  end

  describe file('/var/www/letsencrypt/dev.beermapper.com') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
  end

  describe file('/var/www/letsencrypt/admin.dev.evergreenmenus.com') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
  end

  describe file('/opt/nginx/conf.d/beermapper.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }

    main_server = <<-EOF
server {
  listen 443 ssl;
  server_name dev.beermapper.com;
  root /var/apps/beermapper/current/ember/dist;

  ssl on;
  ssl_certificate /etc/letsencrypt/current/dev.beermapper.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/current/dev.beermapper.com/key.pem;

  location /api/v1/ {
    proxy_pass http://beermapper-api.com;
  }

  location ~ /.well-known/ {
    root /var/www/letsencrypt/dev.beermapper.com;
  }

  include /opt/nginx/snippets/ssl-params.conf;
}
    EOF

    proxy_target = <<-EOF
server {
  listen 80;
  server_name beermapper-api.com;
  access_log logs/beermapper.access.log;

  root /var/apps/beermapper/current/public;
  passenger_enabled on;
  rails_env development;
  charset utf-8;
}
    EOF

    ssl_redirect = <<-EOF
server {
  listen 80;
  server_name dev.beermapper.com;
  rewrite ^(.*)$ https://dev.beermapper.com$1;
}
    EOF

    its(:content) { is_expected.to include main_server }
    its(:content) { is_expected.to include proxy_target }
    its(:content) { is_expected.to include ssl_redirect }
  end

  describe file('/opt/nginx/conf.d/admin.evergreenmenus.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }

    main_server = <<-EOF
server {
  listen 443 ssl;
  server_name admin.dev.evergreenmenus.com;
  access_log logs/evergreen.access.log;

  ssl on;
  ssl_certificate /etc/letsencrypt/current/admin.dev.evergreenmenus.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/current/admin.dev.evergreenmenus.com/key.pem;

  root /var/apps/beermapper/current/public;
  passenger_enabled on;
  rails_env development;
  charset utf-8;

  error_page 404 /404.html;
  location = /404.html {
    root /var/apps/beermapper/current/public/404.html;
    internal;
  }

  error_page 500 502 503 504 /500.html;
  location = /500.html {
    root /var/apps/beermapper/current/public/500.html;
    internal;
  }

  location ~ /.well-known/ {
    root /var/www/letsencrypt/admin.dev.evergreenmenus.com;
  }

  include /opt/nginx/snippets/ssl-params.conf;
}
    EOF
    redirect_www_via_https = <<-EOF
server {
  listen 443 ssl;
  server_name www.admin.dev.evergreenmenus.com;
  rewrite ^(.*)$ https://admin.dev.evergreenmenus.com$1;
}
    EOF
    redirect_http_to_https = <<-EOF
server {
  listen 80;
  server_name admin.dev.evergreenmenus.com;
  rewrite ^(.*)$ https://admin.dev.evergreenmenus.com$1;
}
    EOF
    redirect_www_via_http = <<-EOF
server {
  listen 80;
  server_name www.admin.dev.evergreenmenus.com;
  rewrite ^(.*)$ https://admin.dev.evergreenmenus.com$1;
}
    EOF
    its(:content) { is_expected.to include main_server }
    its(:content) { is_expected.to include redirect_www_via_https }
    its(:content) { is_expected.to include redirect_http_to_https }
    its(:content) { is_expected.to include redirect_www_via_http }
  end

  describe file('/opt/nginx/conf.d/cdn.evergreenmenus.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }

    main_server = <<-EOF
server {
  listen 443 ssl;
  server_name cdn.dev.evergreenmenus.com;
  access_log logs/evergreen.access.log;

  ssl on;
  ssl_certificate /etc/letsencrypt/current/cdn.dev.evergreenmenus.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/current/cdn.dev.evergreenmenus.com/key.pem;

  root /var/apps/beermapper/current/public;
  passenger_enabled on;
  rails_env development;
  charset utf-8;

  error_page 404 /404.html;
  location = /404.html {
    root /var/apps/beermapper/current/public/404.html;
    internal;
  }

  error_page 500 502 503 504 /500.html;
  location = /500.html {
    root /var/apps/beermapper/current/public/500.html;
    internal;
  }

  location ~ /.well-known/ {
    root /var/www/letsencrypt/cdn.dev.evergreenmenus.com;
  }

  include /opt/nginx/snippets/ssl-params.conf;
}
    EOF
    redirect_www_via_https = <<-EOF
server {
  listen 443 ssl;
  server_name www.cdn.dev.evergreenmenus.com;
  rewrite ^(.*)$ https://cdn.dev.evergreenmenus.com$1;
}
    EOF
    redirect_http_to_https = <<-EOF
server {
  listen 80;
  server_name cdn.dev.evergreenmenus.com;
  rewrite ^(.*)$ https://cdn.dev.evergreenmenus.com$1;
}
    EOF
    redirect_www_via_http = <<-EOF
server {
  listen 80;
  server_name www.cdn.dev.evergreenmenus.com;
  rewrite ^(.*)$ https://cdn.dev.evergreenmenus.com$1;
}
    EOF
    its(:content) { is_expected.to include main_server }
    its(:content) { is_expected.to include redirect_www_via_https }
    its(:content) { is_expected.to include redirect_http_to_https }
    its(:content) { is_expected.to include redirect_www_via_http }
  end

  describe file('/etc/ssl/certs/dhparam.pem') do
    it { is_expected.to exist }
  end

  describe file('/opt/nginx/snippets/ssl-params.conf') do
    it { is_expected.to exist }

    its(:content) { is_expected.to include 'ssl_protocols TLSv1 TLSv1.1 TLSv1.2;' }
    its(:content) { is_expected.to include 'ssl_prefer_server_ciphers on;' }
    its(:content) { is_expected.to include 'ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";' }
    its(:content) { is_expected.to include 'ssl_ecdh_curve secp384r1;' }
    its(:content) { is_expected.to include 'ssl_session_cache shared:SSL:10m;' }
    its(:content) { is_expected.to include 'ssl_session_tickets off;' }
    its(:content) { is_expected.to include 'ssl_stapling on;' }
    its(:content) { is_expected.to include 'ssl_stapling_verify on;' }
    its(:content) { is_expected.to include 'resolver 8.8.8.8 8.8.4.4 valid=300s;' }
    its(:content) { is_expected.to include 'resolver_timeout 5s;' }
    its(:content) { is_expected.to include '#add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";' }
    its(:content) { is_expected.to include 'add_header X-Frame-Options SAMEORIGIN;' }
    its(:content) { is_expected.to include 'add_header X-Content-Type-Options nosniff;' }
    its(:content) { is_expected.to include 'ssl_dhparam /etc/ssl/certs/dhparam.pem;' }
  end

  describe file('/etc/letsencrypt/current/admin.dev.evergreenmenus.com/fullchain.pem') do
    it { is_expected.to exist }
    it { is_expected.to be_linked_to '/etc/letsencrypt/self_signed/admin.dev.evergreenmenus.com/cert.pem' }
  end

  describe file('/etc/letsencrypt/current/admin.dev.evergreenmenus.com/key.pem') do
    it { is_expected.to exist }
    it { is_expected.to be_linked_to '/etc/letsencrypt/self_signed/admin.dev.evergreenmenus.com/key.pem' }
  end

  describe file('/etc/letsencrypt/current/dev.beermapper.com/fullchain.pem') do
    it { is_expected.to exist }
    it { is_expected.to be_linked_to '/etc/letsencrypt/self_signed/dev.beermapper.com/cert.pem' }
  end

  describe file('/etc/letsencrypt/current/dev.beermapper.com/key.pem') do
    it { is_expected.to exist }
    it { is_expected.to be_linked_to '/etc/letsencrypt/self_signed/dev.beermapper.com/key.pem' }
  end

  describe file('/etc/systemd/system/nginx.service') do
    it { is_expected.to exist }
    expected = <<-EOF
[Unit]
Description=A high performance web server and a reverse proxy server
After=network.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/opt/nginx/sbin/nginx -t -q -g 'daemon on; master_process on;'
ExecStart=/opt/nginx/sbin/nginx -g 'daemon on; master_process on;'
ExecReload=/opt/nginx/sbin/nginx -g 'daemon on; master_process on;' -s reload
ExecStop=-/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid
TimeoutStopSec=5
KillMode=mixed

[Install]
WantedBy=multi-user.target
    EOF

    its(:content) { is_expected.to include expected }
  end

  describe service('nginx') do
    it { is_expected.to be_enabled }
  end

  describe command('ps -ef | grep nginx') do
    its(:stdout) { is_expected.to match /nginx: master process \/opt\/nginx\/sbin\/nginx/ }
    its(:stdout) { is_expected.to match /www-data .* nginx: worker process/ }
  end
end
