class Users::SessionsController < Devise::SessionsController
  # GET /users/sign_in
  def new
    super
  end

  # POST /users/sign_in
  def create
    super do |resource|
      remember_me = params[:user][:remember_me] == '1'
      if remember_me
        resource.remember_me!
      else
        resource.forget_me!
      end
    end
  end

  # DELETE /users/sign_out
  def destroy
    super
  end
end
