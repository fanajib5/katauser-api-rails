class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access denied', message: exception.message }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: 'Record not found', message: exception.message }, status: :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
