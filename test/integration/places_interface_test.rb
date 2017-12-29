require 'test_helper'

class PlacesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "place interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'

    # Invalid submission
    # 中身が空の投稿
    assert_no_difference 'Place.count' do
      post places_path, params: { place: { content: "" } }
    end
    assert_select 'div#error_explanation'

    # Valid submission
    content = "This place really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Place.count', 1 do
      post places_path, params: { place: { content: content, 
                                                   picture: picture } }
    end
    assert assigns(:place).picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body

    # Delete post
    assert_select 'a', text: 'delete'
    first_place = @user.places.paginate(page: 1).first
    assert_difference 'Place.count', -1 do
      delete place_path(first_place)
    end

    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test "place sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.places.count} places", response.body

    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path

    # 投稿数は0
    assert_match "0 places", response.body

    # 投稿すると増える
    other_user.places.create!(content: "A place")
    get root_path
    assert_match "1 place", response.body
  end
end
