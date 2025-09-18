# frozen_string_literal: true

module AdminAuthorization
  extend ActiveSupport::Concern

  included do
    before_action :require_admin!
  end

  private

  def require_admin!
    unless current_user&.admin?
      if current_user
        redirect_to root_path, alert: "Access denied"
      else
        redirect_to new_user_session_path, alert: "Access denied"
      end
    end
  end
end
