require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @place = places(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Place.count' do
      post places_path, params: { place: { description: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Place.count' do
      delete place_path(@place)
    end
    assert_redirected_to login_url
  end

  # 他人のマイクロポストは消せない
  test "should redirect destroy for wrong place" do
    log_in_as(users(:michael))
    place = places(:ants)
    assert_no_difference 'Place.count' do
      delete place_path(place)
    end
    assert_redirected_to root_url
  end
end
