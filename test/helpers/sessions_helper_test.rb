require "test_helper"

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    remember(@user)
    cookies.encrypted[:user_id] = @user.id
    cookies[:remember_token] = @user.remember_token
  end

  test "current_user returns right user when session is nil" do
  # セッションはnilにする（setupでそうなっている前提）
  session[:user_id] = nil

  # cookiesに値をセット
  cookies.encrypted[:user_id] = @user.id
  cookies[:remember_token] = @user.remember_token

  assert_equal @user, current_user
  assert is_logged_in?
end


  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
