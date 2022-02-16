class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :product_shopping_carts
  has_many :products, through: :product_shopping_carts
end
