class UserNotificationsController < ApplicationController
  before_action :authenticate_user
  before_action :admin_only, only: [:index, :create]

  def index
    user_notifications = UserNotification.all

    if params.has_key? :seen
      user_notifications = user_notifications.seen params[:seen]
    end

    if params.has_key? :user_ids
      user_notifications = user_notifications.where user_id: params[:user_ids].split(',')
    end

    if params.has_key? :sort_by
      sort_order = 'asc'
      if params.has_key? :sort_order
        sort_order = params[:sort_order]
      end
      user_notifications = user_notifications.order(params[:sort_by] => sort_order)
    end

    if params.has_key? :limit
      user_notifications = user_notifications.limit(params[:limit])
    end

    render json: {user_notifications: ActiveModel::Serializer::CollectionSerializer.new(user_notifications)}
  end

  def create
    if !params.has_key?(:user_id) || !params.has_key?(:notification_id)
      render json: {message: "user_id and notification_id expected in url params"}, status: :bad_request and return
    end

    @user_notification = UserNotification.create(
        user_id: params[:user_id],
        notification_id: params[:notification_id],
        seen: false)

    if @user_notification.save
      render json: @user_notification, status: :created
    else
      render json: @user_notification.errors, status: :unprocessable_entity
    end
  end

  def mark_as_seen
    user_notification = UserNotification.find_by id: params[:id], user_id: @current_user
    if user_notification.nil?
      render json: {message: 'No such notification for current user'}, status: :not_found and return
    end
    user_notification.seen = true
    user_notification.save
    render json: {success: true}
  end

end
