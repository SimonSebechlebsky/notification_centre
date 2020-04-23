require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test "wrong user attributes" do
    notification = Notification.new(
        template_text: 'Some template string %s',
        user_attributes: ['nonexistent_attribute'])
    notification.validate
    assert_equal ["Unknown attribute nonexistent_attribute."], notification.errors[:user_attributes]
  end

  test "wrong count of user attributes" do
    notification = Notification.new(
        template_text: 'Some template string %s',
        user_attributes: %w[name created_at])
    notification.validate
    assert_equal ["Expected 1 attributes to fill"], notification.errors[:user_attributes]
  end
end
