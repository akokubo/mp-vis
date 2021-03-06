require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    # ApplicationHelperをインクルードしているので、full_titleヘルパーが使用できる
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    # ページ(response.body)にマイクロポストの件数が含まれる
    assert_match @user.places.count.to_s, response.body
    # assert_select 'div.pagination'
    #@user.places.paginate(page: 1).each do |place|
    #  assert_match place.description, response.body
    #end
  end

=begin
  test "test profile stats on home page" do
    log_in_as(@user)
    # get root_path(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'div.stats', count: 1
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
  end
=end
end
