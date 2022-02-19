class ShoppingCartsController < ApplicationController
  # reference for protect_from_forgery:
  # https://github.com/howardmann/Tutorials/blob/master/Rails_Shopping_Cart.md
  protect_from_forgery with: :exception
  before_action :set_shopping_cart, only: [:show, :checkout, :add_to_cart, :buy_now]
  before_action :require_same_user, only: [:show, :checkout]
  before_action :require_admin, only: [:index]
  before_action :current_cart

  def show
    if !logged_in?
      flash[:notice] = 'Login required'
      redirect_to login_path
    end
  end

  def index
    @shopping_carts = ShoppingCart.all
  end

  def add_to_cart
    @shopping_cart.products << Product.find(session[:product_id])
    ProductShoppingCart.find_by(shopping_cart_id: @shopping_cart.id, product_id: session[:product_id]).update(quantity: session[:product_qty])
    session[:product_qty] = 1
    flash[:notice] = 'Product added to your cart :)'
    redirect_to products_path
  end

  def buy_now
    @shopping_cart.products << Product.find(session[:product_id])
    ProductShoppingCart.find_by(shopping_cart_id: @shopping_cart.id, product_id: session[:product_id]).update(quantity: session[:product_qty])
    session[:product_qty] = 1
    flash[:notice] = 'Commit your order!'
    redirect_to payment_path
  end

  def payment
    @shopping_cart = ShoppingCart.find(session[:cart_id])
  end

  def checkout
    if @shopping_cart.products.any?
      @shopping_cart.checked_in = true
      if @shopping_cart.save
        current_cart
        flash[:notice] = 'Shopping cart checked out successfully'
        redirect_to products_path
      else
        render 'payment'
      end
    else
      flash[:notice] = 'You can not checkout an empty cart'
      redirect_to products_path
    end
  end

  private

  def set_shopping_cart
    if !ShoppingCart.find_by(id: params[:id]).nil?
      @shopping_cart = ShoppingCart.find(params[:id])
    else
      flash[:alert] = 'Shopping cart id not found'
      redirect_to products_path
    end
  end

  def require_same_user
    if !logged_in?
      flash[:alert] = 'Login required'
      redirect_to login_path
    elsif current_user != @shopping_cart.user && !current_user.admin?
      flash[:alert] = 'You can only deal with your own stuff'
      redirect_to root_path
    end
  end
end
