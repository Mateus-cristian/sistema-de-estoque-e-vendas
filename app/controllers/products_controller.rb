class ProductsController < ApplicationController
  include AdminAuthorization
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Produto criado com sucesso"
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity)
  end
end
