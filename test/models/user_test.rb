require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "unique name" do
    user = User.create(name:'test_user1', password:'asdf')
    user2 = User.create(name:'test_user1', password:'qwerty')
    assert_equal user2.errors[:name], ['has already been taken']
  end

end
