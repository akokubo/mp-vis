require 'test_helper'

class PlaceTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @place = @user.places.build(name: "Lorem ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", mass: 3.1, latitude: 37.402473, longitude: -122.3212843, collected_at: 10.minutes.ago)
  end

  test "should be valid" do
    assert @place.valid?
  end

  test "user id should be present" do
    @place.user_id = nil
    assert_not @place.valid?
  end

  test "name should be present" do
    @place.name = "   "
    assert_not @place.valid?
  end

  test "name should be at most 140 characters" do
    @place.name = "a" * 141
    assert_not @place.valid?
  end

  test "mass should be present" do
    @place.mass = nil
    assert_not @place.valid?
  end
  test "mass should be positive" do
    @place.mass = -1.0
    assert_not @place.valid?
  end

  test "latitude should be present" do
    @place.latitude = nil
    assert_not @place.valid?
  end

  test "latitude should be greater or equal -90" do
    @place.latitude = -91
    assert_not @place.valid?
  end

  test "latitude should be less or equal 90" do
    @place.latitude = 91
    assert_not @place.valid?
  end

  test "longitude should be present" do
    @place.longitude = nil
    assert_not @place.valid?
  end

  test "longitude should be greater or equal -180" do
    @place.longitude = -181
    assert_not @place.valid?
  end

  test "longitude should be less or equal 180" do
    @place.longitude = 181
    assert_not @place.valid?
  end

  test "order should be most recent first" do
    assert_equal places(:most_recent), Place.first
  end
end
