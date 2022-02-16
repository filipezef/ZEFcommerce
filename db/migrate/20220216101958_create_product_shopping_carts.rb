class CreateProductShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :product_shopping_carts do |t|
      t.integer :product_id
      t.integer :shopping_cart_id
      t.integer :quantity, default: 1
    end
  end
end
