class Users::RegistrationsController < Devise::RegistrationsController
  
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?

    if resource.persisted?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      resource.errors.full_messages.each do |message|
        flash[:error] = message
      end
      redirect_to new_user_registration_path
    end
  end
end
