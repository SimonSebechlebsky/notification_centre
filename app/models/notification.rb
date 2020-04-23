require 'json'

class Notification < ApplicationRecord
  validates_presence_of :template_text
  # validates_presence_of :user_attributes
  validate :validate_attributes

  def attributes
    if user_attributes.is_a?(String) # string is being returned from db for some reason
      return JSON.parse(user_attributes)
    end
    user_attributes
  end

  private
  def validate_attributes
    attributes.each do |attribute|
      unless User.public_properties.include? attribute
        errors.add(:user_attributes, "Unknown attribute #{attribute}.")
      end
    end
    attributes_count = template_text.scan(/(?=%s)/).count
    if attributes_count != attributes.length
      errors.add(:user_attributes, "Expected %s attributes to fill" % attributes_count)

    end
  end
end
