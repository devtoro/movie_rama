class SecureController < ApplicationController
  before_action :authenticated_user, only: [:create, :update, :destroy]

  private

  def authenticated_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to new_session_path
    end
  end
end
