class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      sign_up(:user, @user)
      redirect_to after_sign_up_path_for(@user)
    else
      render :new
    end
  end

 def update
    @user = User.find(current_user.id)

    successfully_updated = params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password, :username, :email, :nickname, :url, :provider) }
    end

end