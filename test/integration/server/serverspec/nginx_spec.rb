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

  describe file('/opt/nginx/conf/nginx.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
  end

  describe file('/opt/nginx/conf/passenger.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }
  end

  describe file('/opt/nginx/conf/beermapper.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_mode 644 }
  end

  describe service('nginx') do
    it { is_expected.to be_enabled }
  end

  describe command('ps -ef | grep nginx') do
    its(:stdout) { is_expected.to match /nginx: master process \/opt\/nginx\/sbin\/nginx/ }
    its(:stdout) { is_expected.to match /www-data .* nginx: worker process/ }
  end
end
