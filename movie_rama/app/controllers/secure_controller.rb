class SecureController < ApplicationController
  before_action :authenticated_user, only: %i[create update destroy]

  private

  def authenticated_user
    return if logged_in?

    store_location
    flash[:error] = 'Please log in first'
    redirect_to login_path
  end
end
