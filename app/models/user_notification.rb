class UserNotification < ApplicationRecord
  has_one :notification
  belongs_to :user
end
