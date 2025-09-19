# frozen_string_literal: true

class Admin::ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : 7.days.ago.to_date
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today
    @sales = Sale.where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
  end
end
