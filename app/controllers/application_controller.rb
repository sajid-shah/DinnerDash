# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :user_permit, if: :devise_controller?
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # def routing_error(_error = 'Routing error', _status = :not_found, _exception = nil)
  #   render file: 'public/404.html', status: :not_found, layout: false
  # end

  protected

  def user_permit
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fullname displayname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname displayname])
  end

  private

  def record_not_found
    flash[:alert] = t(:record_not_found)
    redirect_to request.referer || root_path
  end

  def user_not_authorized
    flash[:alert] = t(:you_are_not_authorize)
    redirect_to(request.referer || root_path)
  end
end
