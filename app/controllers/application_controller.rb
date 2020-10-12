class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from UnauthorizedException, with: :user_unauthorized


  private

  def user_unauthorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
