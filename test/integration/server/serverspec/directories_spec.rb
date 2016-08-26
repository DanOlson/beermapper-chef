require 'spec_helper'

describe file('/var/apps') do
  it { is_expected.to exist }
  it { is_expected.to be_mode 755 }
end
