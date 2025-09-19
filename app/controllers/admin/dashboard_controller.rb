# frozen_string_literal: true


class Admin::DashboardController < ApplicationController
  include AdminAuthorization
  before_action :authenticate_user!


  def index
    @total_sales = Sale.count
    @low_stock_products = Product.where("quantity < ?", 5)
  end
end
