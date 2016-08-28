require 'spec_helper'

describe package('git') do
  it { is_expected.to be_installed }
end
