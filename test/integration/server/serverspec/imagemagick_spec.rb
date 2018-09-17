require 'spec_helper'

describe 'imagemagick installation' do
  describe package('imagemagick') do
    it { is_expected.to be_installed }
  end

  describe command('convert -list configure | grep DELEGATES') do
    its(:stdout) { is_expected.to include 'png' }
    its(:stdout) { is_expected.to include 'jpeg' }
  end
end
