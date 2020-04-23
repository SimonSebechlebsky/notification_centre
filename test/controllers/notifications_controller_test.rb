require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_headers = {"Authorization" => "Basic #{Base64.encode64('AdminUser:adminpassword')}"}
  end

  test "should get index" do
    get notifications_url, as: :json
    assert_response :success
  end

  test "should create notification" do
      notification = Notification.new(template_text: "Hello %s!", user_attributes: ["name"] )
      post notifications_url, params: {
          notification: {
              template_text: notification.template_text, user_attributes: notification.attributes
          }
      }, as: :json, headers: @auth_headers

    assert_response 201
  end

end
