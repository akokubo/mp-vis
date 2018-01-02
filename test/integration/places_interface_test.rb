require 'test_helper'

class PlacesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

=begin
  test "place interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'

    # Invalid submission
    # 中身が空の投稿
    assert_no_difference 'Place.count' do
      post places_path, params: { place: { name:"", description: "" } }
    end
    assert_select 'div#error_explanation'

    # Valid submission
    name = "This place really ties the room together"
    description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    mass = 3.1
    latitude = 37.402473
    longitude = -122.3212843
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    collected_at = 10.minutes.ago
    assert_difference 'Place.count', 1 do
      post places_path, params: { place: { name: name, description: description, mass: mass, latitude: latitude, longitude: longitude, picture: picture, collected_at: collected_at } }
    end
    assert assigns(:place).picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match description, response.body

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
    other_user.places.create!(name: "A place", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", mass: 3.1, latitude: 37.402473, longitude: -122.3212843, collected_at: 10.minutes.ago)
    get root_path
    assert_match "1 place", response.body
  end
=end
end
