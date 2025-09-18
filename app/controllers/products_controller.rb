# frozen_string_literal: true

class ProductsController < ApplicationController
  include AdminAuthorization
  before_action :authenticate_user!

  def index
    @products = Product.all
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: "Produto criado com sucesso" }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream:
          turbo_stream.replace(
              "product_form",
              partial: "products/form",
              locals: { product: @product }),
            status: :unprocessable_entity
        end
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity)
  end
end
