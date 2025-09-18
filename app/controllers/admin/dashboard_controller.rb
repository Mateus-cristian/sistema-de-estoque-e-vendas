# frozen_string_literal: true


class Admin::DashboardController < ApplicationController
  include AdminAuthorization
  before_action :authenticate_user!


  def index
  end
end
