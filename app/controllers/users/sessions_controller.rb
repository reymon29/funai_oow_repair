class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    # respond_to do |format|
    #   format.js { render :js => "signInSweetAlertButton();" }
    # end
  end

  # DELETE /resource/sign_out
  def destroy
    user = current_user
    if current_user.admin?
      online = UserOnline.find_by(user: user)
      if online.nil?
      else
        online.destroy
      end
    else
    end
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
