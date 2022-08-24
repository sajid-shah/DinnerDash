# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :user_permit, if: :devise_controller?
  protected

  def user_permit
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fullname displayname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname displayname])
  end
end
