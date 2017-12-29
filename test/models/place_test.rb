require 'test_helper'

class PlaceTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @place = @user.places.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @place.valid?
  end

  test "user id should be present" do
    @place.user_id = nil
    assert_not @place.valid?
  end

  test "content should be present" do
    @place.content = "   "
    assert_not @place.valid?
  end

  test "content should be at most 140 characters" do
    @place.content = "a" * 141
    assert_not @place.valid?
  end

  test "order should be most recent first" do
    assert_equal places(:most_recent), Place.first
  end
end
