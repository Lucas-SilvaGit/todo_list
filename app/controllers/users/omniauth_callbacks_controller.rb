class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Gmail') if is_navigational_format?
      puts request.env['omniauth.auth']
    else
      redirect_to root_path, alert: 'Falha na autenticação do Gmail'
    end
  end
end
