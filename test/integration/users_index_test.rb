require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'

    first_page_of_users = User.where(activated: true).paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end

    # delete test
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "should display only activated users" do
    # 最初のユーザーを無効化
    user = User.first
    user.update!(activated: false)

    log_in_as(@admin)
    get users_path

    # ページに表示されているユーザーの名前を確認
    User.where(activated: true).paginate(page: 1).each do |u|
      next unless u.activated?
      assert_select 'a[href=?]', user_path(u), text: u.name
    end
  end
end


