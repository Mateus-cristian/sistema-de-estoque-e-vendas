# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @count = params[:count].to_i
  end
end
