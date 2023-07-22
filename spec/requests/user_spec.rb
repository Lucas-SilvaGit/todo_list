# spec/requests/user_spec.rb

require 'rails_helper'

RSpec.describe "User Registration", type: :request do
  describe "POST /users" do
    context "com dados válidos" do
      it "cadastra um novo usuário e redireciona para a página de login" do
        user_params = {
          user: {
            email: "novo_usuario@example.com",
            password: "senha123",
            password_confirmation: "senha123"
          }
        }

        expect {
          post user_registration_path, params: user_params
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "com dados inválidos" do
      it "não cadastra um novo usuário e exibe mensagens de erro" do
        user_params = {
          user: {
            email: "email_invalido",
            password: "senha123",
            password_confirmation: "senha456" # Senhas não coincidem
          }
        }

        expect {
          post user_registration_path, params: user_params
        }.not_to change(User, :count)
      end
    end
  end
end
