class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:show, :index]

  def show
    # to enable product to be added to shopping cart at product show page by logged in user
    if session[:product_id] != @product.id
      session[:product_id] = @product.id
      session[:product_qty] = 1
    end
  end

  def index
    @products = Product.paginate(page: params[:page], per_page: 5)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Product created successfully'
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = 'Product updated successfully'
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = 'Product deleted successfully'
    redirect_to products_path
  end

  private

  def set_product
    if !Product.find_by(id: params[:id]).nil?
      @product = Product.find(params[:id])
    else
      flash[:alert] = 'Product id not found'
      redirect_to products_path
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :value)
  end
end
