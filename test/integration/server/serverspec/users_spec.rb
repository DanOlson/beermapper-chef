require 'spec_helper'

MY_PUB_KEY = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVtwD++vZge73GQG7NrLH03iVitcPUjYixCFBaJ9OtBdyHTnBUiWYJjsJYixIb+RvcragKNGiF70mN5m+HSdHm/FLfSMNn1StdIu3cw4lB4/aLAq8SCtSS0yds9WPvH2XvekvMxT1SxdI2IF/22GRPjkWGLZiyNGGWf/KUa8fqq4fpZiJVhXnCM8BNWKZyXiimnx6vU0Nyci7zR1EQSSbXsPAqjoNbZx5HIbibPPYtBF7Gq+NvQ83Uj3v1VvaPlrGZzX3ydVPjt/ISVXHAN2U6slXibrgtMfPg5Dp7HJf8fHme3O7+njP0ZBFE1aqHPn9XBfQBMOW3bLZHtlEWy7GP dan@Daniels-MacBook-Air.local'

describe 'beermapper-users' do
  describe user('deploy') do
    it { is_expected.to exist }
    it { is_expected.to belong_to_group 'deploy' }
    it { is_expected.to have_home_directory '/home/deploy' }
    it { is_expected.to have_login_shell '/bin/bash' }
    it { is_expected.to have_authorized_key MY_PUB_KEY }
  end
end
