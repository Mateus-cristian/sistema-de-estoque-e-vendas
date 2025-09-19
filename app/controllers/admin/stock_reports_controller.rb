# frozen_string_literal: true

class Admin::StockReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @threshold = (params[:threshold] || 5).to_i
    @products = Product.where("quantity < ?", @threshold)
  end
end
