class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # def create
  #   super
  #
  #   @user = User.new(user_params)
  #
  #   if @user.save
  #     UserMailer.registration_confirmation(@user).deliver
  #     flash[:success] = "Please confirm your email address to continue"
  #     redirect_to root_url
  #   else
  #     flash[:error] = "Something went very wrong"
  #     render
  #   end
  # end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  #
  #
  # protected


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
