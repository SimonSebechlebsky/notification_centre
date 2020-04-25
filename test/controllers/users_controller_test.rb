require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should not get index without basic auth" do
    get users_url, as: :json
    assert_response :unauthorized
  end

  test "should not get index without admin rights" do
    auth_headers = {"Authorization" => "Basic #{Base64.encode64('BasicUser:basicpassword')}"}
    get users_url, as: :json, headers: auth_headers
    assert_response :forbidden
  end

  test "should get index" do
    auth_headers = {"Authorization" => "Basic #{Base64.encode64('AdminUser:adminpassword')}"}
    get users_url, as: :json, headers: auth_headers
    users = json_response['users']
    assert_equal users[0]['name'], 'AdminUser'
    assert_equal users[0]['admin'], true
    assert_equal users[1]['name'], 'BasicUser'
    assert_equal users[1]['admin'], false
    assert_equal users[0].keys.sort, %w[id name created_at updated_at admin].sort
  end

  test "should get current user notifications" do
    auth_headers = {"Authorization" => "Basic #{Base64.encode64('BasicUser:basicpassword')}"}
    get '/my_notifications', as: :json, headers: auth_headers
    assert_equal json_response['notifications'][0]['text'], 'Hello BasicUser, welcome to Yova!'
  end

end
