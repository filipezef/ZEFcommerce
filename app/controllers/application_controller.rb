class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = 'Login required'
      redirect_to login_path
    end
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:alert] = 'Action restricted to admin account'
      redirect_to root_path
    end
  end

  def current_cart
    if session[:cart_id]
      shopping_cart = ShoppingCart.find(session[:cart_id])
      if shopping_cart.present? && !shopping_cart.checked_in?
        @current_shopping_cart = shopping_cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id] == nil
      if current_user
        if !current_user.shopping_carts.find_by(checked_in: false)
          @current_shopping_cart = ShoppingCart.create(user_id: session[:user_id], checked_in: false, delivered: false)
        else
          @current_shopping_cart = current_user.shopping_carts.find_by(checked_in: false)
        end
      	session[:cart_id] = @current_shopping_cart.id
      end
    end
  end
end
