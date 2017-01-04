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

  describe file('/opt/nginx/conf.d/beermapper.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }
    its(:content) { is_expected.to include 'rails_env development;' }
    its(:content) { is_expected.to include 'server_name dev.beermapper.com;' }
  end

  describe file('/opt/nginx/conf.d/admin.beermapper.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }
    its(:content) { is_expected.to include 'rails_env development;' }
    its(:content) { is_expected.to include 'server_name admin.dev.beermapper.com;' }
    its(:content) { is_expected.to include 'root /var/apps/beermapper/current/public;' }
    its(:content) { is_expected.to include 'listen 80;' }
    its(:content) { is_expected.to include 'passenger_enabled on;' }
  end

  describe service('nginx') do
    it { is_expected.to be_enabled }
  end

  describe command('ps -ef | grep nginx') do
    its(:stdout) { is_expected.to match /nginx: master process \/opt\/nginx\/sbin\/nginx/ }
    its(:stdout) { is_expected.to match /www-data .* nginx: worker process/ }
  end
end
