describe 'node installation' do
  describe command('node -v') do
    its(:stdout) { is_expected.to match /6\.3\.1/ }
  end
end
