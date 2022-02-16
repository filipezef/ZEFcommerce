class AddToShoppingCartsBooleanColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :shopping_carts, 'delivered', :boolean, default: false
    add_column :shopping_carts, 'checked_in', :boolean, default: false
  end
end
