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
      flash[:notice] = I18n.t("products.created")
      respond_to do |format|
        format.html { redirect_to products_path }
        format.turbo_stream { head :see_other, location: products_path }
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
        flash[:notice] = I18n.t("products.updated")
        format.html { redirect_to products_path }
        format.turbo_stream { head :see_other, location: products_path }
      else
        format.html { render :form_page, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "product_form",
            partial: "products/form",
            locals: { product: @product }
          ), status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    begin
      @product.destroy
      flash[:notice] = I18n.t("products.removed")
      respond_to do |format|
        format.html { redirect_to products_path }
        format.turbo_stream
      end
    rescue ActiveRecord::InvalidForeignKey
      flash[:alert] = I18n.t("products.cannot_remove_linked")
      respond_to do |format|
        format.html { redirect_to products_path }
        format.turbo_stream { render "shared/toast" }
      end
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
