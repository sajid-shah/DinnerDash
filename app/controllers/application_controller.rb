# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :user_permit, if: :devise_controller?
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def user_permit
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fullname displayname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname displayname])
  end

  private

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found_error', layout: '/public', status: :not_found }
      format.all  { render nothing: true, status: :not_found }
    end
  end

  def record_not_found
    flash[:alert] = t(:record_not_found)
    redirect_to request.referer || root_path
  end

  def user_not_authorized
    flash[:alert] = t(:you_are_not_authorize)
    redirect_to(request.referer || root_path)
  end
end
