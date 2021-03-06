class SessionsController < ApplicationController
  # reference for protect_from_forgery:
  # https://github.com/howardmann/Tutorials/blob/master/Rails_Shopping_Cart.md
  protect_from_forgery with: :exception

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:user_admin] = user.admin?
      session[:product_id] = nil
      session[:cart_id] = nil
      session[:product_qty] = 1
      flash[:notice] = 'You have successfully loged in.'
      current_cart
      redirect_to products_path
    else
      flash.now[:alert] = 'User name and/or password are incorrect'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_admin] = nil
    session[:product_id] = nil
    session[:cart_id] = nil
    session[:product_qty] = 1
    flash[:notice] = 'You have successfully logged out'
    redirect_to products_path
  end

  def add_quantity
    session[:product_qty] += 1
    redirect_to product_path(Product.find(session[:product_id]))
  end

  def reduce_quantity
    if session[:product_qty] > 1
      session[:product_qty] -= 1
    else
      flash[:notice] = 'Minium quantity is 1!'
    end
    redirect_to product_path(Product.find(session[:product_id]))
  end
end
