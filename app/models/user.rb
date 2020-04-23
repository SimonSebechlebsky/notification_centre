class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :user_notifications

  def self.public_properties # used in creating notifications template texts
    %w[name created_at]
  end

end
