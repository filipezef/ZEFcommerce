class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :product_shopping_carts
  has_many :shopping_carts, through: :product_shopping_carts
  validates :name, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 }
  validates :description, presence: true,
                          uniqueness: { case_sensitive: false },
                          length: { minimum: 20, maximum: 2000 }
  validates :value, presence: true, numericality: true
end
