class UserNotification < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  scope :seen, ->(value) { where seen: value }


  def text
    mapped_attributes = notification.attributes.map do |attribute|
      if User.public_properties.include? attribute
        next user.public_send(attribute)
      end
      logger.error "Unknown atrribute is being rendered in user notification"
      "UNKNOWN ATTRIBUTE"
    end
    notification.template_text % mapped_attributes
  end
end
