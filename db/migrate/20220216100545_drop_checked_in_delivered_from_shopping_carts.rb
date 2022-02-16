class DropCheckedInDeliveredFromShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    remove_column :shopping_carts, :checked_in
    remove_column :shopping_carts, :delivered
  end
end
