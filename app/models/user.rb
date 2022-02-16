class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :shopping_carts, dependent: :destroy

  validates :name, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 10, maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 5 }

  has_secure_password
end
