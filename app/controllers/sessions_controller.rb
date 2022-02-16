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
    flash[:notice] = 'You have successfully logged out'
    redirect_to root_path
  end
end
