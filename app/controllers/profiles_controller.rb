class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_password, only: [:update]
  before_action :set_user

  def edit
  end

  def update
    if @user.update(params_user)
      flash[:notice] = 'Profile updated successfully'
      redirect_to edit_profiles_path
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end  

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def params_user
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end

  def verify_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end
end

