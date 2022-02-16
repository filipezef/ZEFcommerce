class ProductShoppingCartsController < ApplicationController
  before_action :set_product_shopping_cart, only: [:add_quantity, :reduce_quantity, :destroy]

  # reference for add_quantity, reduce_quantity and destroy actions:
  # https://github.com/howardmann/Tutorials/blob/master/Rails_Shopping_Cart.md
  def add_quantity
    @product_shopping_cart.quantity += 1
    @product_shopping_cart.save
    redirect_to shopping_cart_path(current_user.shopping_carts.last)
  end

  def reduce_quantity
    if @product_shopping_cart.quantity > 1
      @product_shopping_cart.quantity -= 1
    else
      flash[:notice] = 'Remove the item from your shopping cart'
    end
    @product_shopping_cart.save
    redirect_to shopping_cart_path(current_user.shopping_carts.last)
  end

  def destroy
    @product_shopping_cart.destroy
    redirect_to shopping_cart_path(current_user.shopping_carts.last)
  end

  private

  def set_product_shopping_cart
    @product_shopping_cart = ProductShoppingCart.find(params[:id])
  end
end
