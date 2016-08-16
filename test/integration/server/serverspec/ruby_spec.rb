require 'spec_helper'

describe 'ruby installation' do
  describe file('/etc/profile.d/rvm.sh') do
    it { is_expected.to exist }
    it { is_expected.to be_executable }
  end

  describe file('/usr/local/rvm/rubies/ruby-2.3.0') do
    it { is_expected.to exist }
    it { is_expected.to be_directory }
  end

  describe file('/usr/local/rvm/rubies/default') do
    it { is_expected.to be_linked_to '/usr/local/rvm/rubies/ruby-2.3.0' }
  end
end
