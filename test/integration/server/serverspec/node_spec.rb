describe 'node installation' do
  describe command('node -v') do
    its(:stdout) { is_expected.to match /6\.3\.1/ }
  end

  describe command('ember -v') do
    its(:stdout) { is_expected.to match /1\.13\.13/ }
  end

  describe command('bower -v') do
    its(:stdout) { is_expected.to match /1\.8\.0/ }
  end
end
