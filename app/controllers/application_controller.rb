class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate_user
    auth_successful = authenticate_with_http_basic do |username, password|
      user = User.find_by name: username
      begin
        if user.nil? || !user.authenticate(password)
          next false
        end
      rescue
        next false
      end
      @current_user = user
    end
    unless auth_successful
      render  json: {message: "Couldn't authenticate user"}, status: :unauthorized
    end
  end

  def admin_only
    unless @current_user.admin
      render  json: {message: "You don't have sufficient permissions to acces this route"}, status: :forbidden
    end
  end
end
