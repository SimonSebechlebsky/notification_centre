class UserNotificationSerializer < ActiveModel::Serializer
  attributes :id, :seen, :text, :user_id, :notification_id, :created_at, :updated_at
end
