# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if user_signed_in?
      render :index
    else
      render template: "landing/index"
    end
  end
end
