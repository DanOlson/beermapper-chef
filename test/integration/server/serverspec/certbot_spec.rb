require 'spec_helper'

describe 'cerbot installation' do
  describe package('software-properties-common') do
    it { is_expected.to be_installed }
  end

  describe ppa('ppa:certbot/certbot') do
    it { is_expected.to exist }
    it { is_expected.to be_enabled }
  end

  describe package('certbot') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/letsencrypt') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
  end

  describe cron do
    cron_entry = '@daily /usr/bin/certbot renew --deploy-hook "/bin/systemctl reload nginx"'
    it { is_expected.to have_entry(cron_entry).with_user('root') }
  end
end
