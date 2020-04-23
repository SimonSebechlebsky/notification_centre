class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :template_text, :user_attributes
end
