class ApplicationController < ActionController::Base
  before_action :set_resource, only: %i[show edit update destroy]
  include SessionsHelper

  rescue_from UnauthorizedException, with: :user_unauthorized

  private

  def user_unauthorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  # Set instance variable in controller named after controller name
  # i.e. UsersController will set @user
  def set_resource
    resource_class = controller_name.classify
    resource = resource_class.constantize.find(params[:id]) rescue nil
    instance_variable_set("@#{controller_name.singularize}", resource)
  end
end
