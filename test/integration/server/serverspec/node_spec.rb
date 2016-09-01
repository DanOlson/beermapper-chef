describe 'node installation' do
  describe command('node -v') do
    its(:stdout) { is_expected.to match /0\.10\.36/ }
  end

  describe command('ember -v') do
    its(:stdout) { is_expected.to match /1\.13\.13/ }
  end

  describe command('bower -v') do
    its(:stdout) { is_expected.to match /1\.7\.9/ }
  end
end
