class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      set_flash_message!(:alert, :invalid)
      flash[:error] = resource.errors.full_messages.join(", ") if resource.errors.any? # Adicione esta linha
      redirect_to new_user_session_path
    end
  end
  
  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
