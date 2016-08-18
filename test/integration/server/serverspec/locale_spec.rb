require 'spec_helper'

describe command('locale') do
  let(:locales) do
    subject.stdout.scan(/LC_.*=(.*)$/).flatten.uniq
  end

  it 'has UTF-8 encoding' do
    expect(locales.all? { |l| l['en_US.utf8'] }).to eq true
  end
end
