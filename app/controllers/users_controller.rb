class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :admin_only

  def index
    limit = params['limit'] || 50
    users = User.all.limit(limit)
    render json: {users: ActiveModel::Serializer::CollectionSerializer.new(users)}
  end

  # DELETE /users/1
  def destroy
    user = User.find_by id: params[:id]
    render json: user.destroy
  end

end
