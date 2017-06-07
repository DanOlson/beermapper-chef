require 'spec_helper'

describe 'ufw' do
  rules = [
    %r{22/tcp\s+ALLOW IN\s+Anywhere},
    %r{80/tcp\s+ALLOW IN\s+Anywhere},
    %r{443/tcp\s+ALLOW IN\s+Anywhere},
    %r{22/tcp \(v6\)\s+ALLOW IN\s+Anywhere \(v6\)},
    %r{80/tcp \(v6\)\s+ALLOW IN\s+Anywhere \(v6\)},
    %r{443/tcp \(v6\)\s+ALLOW IN\s+Anywhere \(v6\)}
  ]

  describe service('ufw') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe command('ufw status numbered') do
    its(:stdout) { is_expected.to match /Status: active/ }

    rules.each do |rule|
      its(:stdout) { is_expected.to match rule }
    end
  end
end
