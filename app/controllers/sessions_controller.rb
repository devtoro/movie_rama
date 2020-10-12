class SessionsController < ApplicationController
  def create
    user = User.find_by(email: login_params[:email].try(:downcase))
    if user && user.authenticate(login_params[:password])
      log_in user
      redirect_back_or root_path
    else
      flash[:error] = 'Invalid email/password combination'
      render template: 'sessions/new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def login_params
    params.require(:session).permit(:email, :password)
  end
end
