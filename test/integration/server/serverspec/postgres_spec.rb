require 'spec_helper'

describe 'postgres installation' do
  describe command('ps -ef | grep postgres') do
    its(:stdout) { is_expected.to match '/usr/lib/postgresql/9.4/bin/postgres -D /var/lib/postgresql/9.4/main -c config_file=/etc/postgresql/9.4/main/postgresql.conf' }
  end

  describe command('psql -l beermapper_production') do
    let(:db_info) do
      keys = %i(name owner encoding collate ctype access_privileges)
      output = subject.stdout.split("\n").find { |line| line.match /^\s+?beermapper_production/ }
      Hash[keys.zip(output.split("|").map(&:strip))]
    end

    it 'has the correct database name' do
      expect(db_info[:name]).to eq 'beermapper_production'
    end

    it 'has UTF8 encoding' do
      expect(db_info[:encoding]).to eq 'UTF8'
    end
  end
end
