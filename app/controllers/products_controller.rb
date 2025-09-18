# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[update destroy form_page]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    render :form_page
  end

  def form_page
    render :form_page
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
        format.html { render :form_page, status: :unprocessable_entity }
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

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: "Produto atualizado com sucesso" }
        format.turbo_stream
      else
        format.html { render :form_page, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "product_form",
            partial: "products/form",
            locals: { product: @product }
          )
        end
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path, notice: "Produto removido com sucesso" }
      format.turbo_stream
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity)
  end
end
