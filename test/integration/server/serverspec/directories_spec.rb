require 'spec_helper'
require 'yaml'

%w(
  /var/apps
  /var/apps/beermapper
  /var/apps/beermapper/releases
  /var/apps/beermapper/shared
  /var/apps/beermapper/shared/assets
  /var/apps/beermapper/shared/bundle
  /var/apps/beermapper/shared/config
  /var/apps/beermapper/shared/log
  /var/apps/beermapper/shared/pids
  /var/apps/beermapper/shared/system
).each do |dir|
  describe file(dir) do
    it { is_expected.to exist }
    it { is_expected.to be_mode 775 }
    it { is_expected.to be_owned_by 'deploy' }
    it { is_expected.to be_grouped_into 'deploy' }
  end
end

describe file('/var/apps/beermapper/shared/config/database.yml') do
  let(:config) { YAML.load(subject.content)['development'] }
  it { is_expected.to exist }
  it { is_expected.to be_mode 600 }
  it { is_expected.to be_owned_by 'deploy' }
  it { is_expected.to be_grouped_into 'deploy' }
  its(:content) { is_expected.to start_with 'development:' }

  it 'has configurable adapter' do
    expect(config['adapter']).to eq 'postgresql'
  end

  it 'has configurable username' do
    expect(config['username']).to eq 'root'
  end

  it 'has configurable password' do
    expect(config['password']).to eq 'password'
  end

  it 'has configurable database name' do
    expect(config['database']).to eq 'beermapper_production'
  end
end

describe file('/var/apps/beermapper/shared/config/app_config.yml') do
  let(:config) { YAML.load(subject.content)['development'] }
  it { is_expected.to exist }
  it { is_expected.to be_mode 600 }
  it { is_expected.to be_owned_by 'deploy' }
  it { is_expected.to be_grouped_into 'deploy' }
  its(:content) { is_expected.to start_with 'development:' }

  it 'has configurable api_key' do
    expect(config['api_key']).to eq 'myrug'
  end

  it 'has configurable secret_token' do
    expect(config['secret_token']).to eq 'secret'
  end

  it 'has configurable web_menu_host' do
    expect(config['web_menu_host']).to eq 'cdn.dev.evergreenmenus.com'
  end

  it 'has google client_id' do
    expect(config).to have_key 'google'
    expect(config['google']).to have_key 'client_id'
  end

  it 'has google client_secret' do
    expect(config).to have_key 'google'
    expect(config['google']).to have_key 'client_secret'
  end

  it 'has facebook client_id' do
    expect(config).to have_key 'facebook'
    expect(config['facebook']).to have_key 'client_id'
  end

  it 'has facebook client_secret' do
    expect(config).to have_key 'facebook'
    expect(config['facebook']).to have_key 'client_secret'
  end

  it 'has stripe pub_key' do
    expect(config).to have_key 'stripe'
    expect(config['stripe']).to have_key 'pub_key'
  end

  it 'has stripe api_key' do
    expect(config).to have_key 'stripe'
    expect(config['stripe']).to have_key 'api_key'
  end

  it 'has stripe webook_secret' do
    expect(config).to have_key 'stripe'
    expect(config['stripe']).to have_key 'webhook_secret'
  end
end
