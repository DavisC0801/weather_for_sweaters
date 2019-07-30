class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :api_key, presence: true, uniqueness: true
end
