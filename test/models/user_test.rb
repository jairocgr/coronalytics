require "test_helper"

class UserTest < ActiveSupport::TestCase

  DEFAULT_USERS_PASSWD = "F3D9319EAE2E7"

  test "should not save a empty user" do
    assert_raises do
      user = User.new
      user.save!
    end
  end

  test "correctly validate password" do
    user = User.find_by email: "wbright@gmail.com"
    assert user.authenticate(DEFAULT_USERS_PASSWD)
  end
end
