# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :role ])
  end

  private

  def user_not_authorized
    head :forbidden
  end

  def after_sign_in_path_for(resource)
    home_path
  end
end
