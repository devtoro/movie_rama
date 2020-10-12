class UsersController < ApplicationController
  before_action :authorize_user, only: :update

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "Account for #{@user.full_name} created successfully"
      redirect_to login_path
    else
      respond_to do |format|
        format.js {}
      end
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Account for #{@user.full_name} update successfully"
      redirect_to edit_user_path
    else
      respond_to do |format|
        format.js {}
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :full_name,
      :email,
      :password
    )
  end

  def authorize_user
    return true if current_user.present? && (@user.id == current_user.id)

    raise UnauthorizedException
  end
end
