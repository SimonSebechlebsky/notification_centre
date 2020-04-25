require 'test_helper'

class UserNotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_headers = {"Authorization" => "Basic #{Base64.encode64('AdminUser:adminpassword')}"}
  end

  test "should mark notification as seen" do
    get "/user_notification/3/seen", as: :json, headers: @auth_headers
    assert UserNotification.find(3).seen
    assert_response 200
  end

  test "should get user notifications sorted" do
    get '/user_notifications?sort_by=created_at&sort_order=desc', as: :json, headers: @auth_headers
    timestamps = json_response['user_notifications'].map do |user_notification|
      user_notification['created_at']
      end
    assert_equal timestamps, timestamps.sort
  end

  test "should get user notifications for user 1" do
    get '/user_notifications?user_ids=1', as: :json, headers: @auth_headers
    assert_equal json_response['user_notifications'].length, 2
  end

  test "should get user notifications for user 1 and 2" do
    get '/user_notifications?user_ids=1,2', as: :json, headers: @auth_headers
    assert_equal json_response['user_notifications'].length, 4
  end



end
