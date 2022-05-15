# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if !self.params["user"]["password"].empty? && !self.params["user"]["password_confirmation"].empty? &&
      self.params["user"]["password_confirmation"] == self.params["user"]["password"] &&
      self.params["user"]["password"].chars.count >= 6 && !self.params["user"]["name"].empty? &&
      !self.params["user"]["email"].empty?
      if Person.find_by(email: self.params["user"]["email"]).nil?
        person = Person.new
        person.name = self.params["user"]["name"]
        person.password = self.params["user"]["password"]
        person.email = self.params["user"]["email"]
        person.roles = 1
      end
      if person.save
        redirect_to "/users/sign_in", notice: "Usuario creado con exito. \n Ahora puede iniciar sesión"
      else
        super
      end
    else
      super
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
