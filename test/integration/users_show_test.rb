require "test_helper"

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @inactive_user  = users(:inactive)   # fixtures/users.yml に inactive を追加済み
    @activated_user = users(:archer)     # fixtures/users.yml に activated なユーザー
  end

  # 無効ユーザーの show ページにアクセスした場合はリダイレクトされることを確認
  test "should redirect when user not activated" do
    get user_path(@inactive_user)
    assert_response :redirect
    assert_redirected_to root_url
  end

  # 有効ユーザーの show ページは正常に表示されることを確認
  test "should display user when activated" do
    get user_path(@activated_user)
    assert_response :success
    assert_template 'users/show'
  end
end