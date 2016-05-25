require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:user_stock)
    @user2 = User.last
  end

  def teardown
    @user1 = nil
    @user2 = nil
  end
  
  test "initialize" do
    assert_instance_of(User, @user1)
  end

  #CRU
  test "create" do
    assert @user1.save
  end

  test "read" do
    assert_equal(6,@user2.id)
  end

  test "update" do
    @user2.email = 'admin2@admin2.com'
    @user2.save
    @user2 = User.last
    assert_equal('admin2@admin2.com',@user2.email)
  end
end
