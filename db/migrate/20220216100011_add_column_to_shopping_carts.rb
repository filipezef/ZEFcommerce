class AddColumnToShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :shopping_carts, :delivered, :string, default: false
    add_column :shopping_carts, :checked_in, :string, default: false
  end
end
