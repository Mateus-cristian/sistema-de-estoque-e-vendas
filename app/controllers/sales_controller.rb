# frozen_string_literal: true

class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    if @sale.save
      redirect_to sales_path, notice: "Sale was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:product_id, :quantity)
  end
end
