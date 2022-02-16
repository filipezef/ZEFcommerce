class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:new, :create]
  before_action :require_same_user, only: [:show, :edit, :update]
  before_action :require_admin, only: [:index, :destroy]

  def show
    @shopping_carts = @user.shopping_carts
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:user_admin] = false
      session[:product_id] = nil
      current_cart
      flash[:notice] = 'You have successfully signed up'
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User updated successfully'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = 'User was deleted successfully'
    redirect_to users_path
  end

  private

  def set_user
    if !User.find_by(id: params[:id]).nil?
      @user = User.find(params[:id])
    else
      flash[:alert] = 'User id not found'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :cpf, :password, :ddd_phone, :number_phone, :street_address,
                                 :number_address, :neighborhood_address, :adders_address, :city_address, :state_address,
                                 :zip_address, :country_address)
  end

  def require_same_user
    if current_user
      if current_user != @user && !current_user.admin?
        flash[:alert] = 'You can only deal with your own stuff'
        redirect_to @user
      end
    end
  end
end
