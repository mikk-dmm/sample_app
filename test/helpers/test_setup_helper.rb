# test/helpers/test_setup_helper.rb
module TestSetupHelper
  def log_in_as_test_user
    @user = users(:michael)
    log_in_as(@user)
  end
end
