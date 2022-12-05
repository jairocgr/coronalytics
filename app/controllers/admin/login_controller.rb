class Admin::LoginController < Admin::AdminController
  layout "admin_login"

  def form
    @credential = Admin::Credential.new()
  end

  def authenticate
    @credential = Admin::Credential.new(credential_params)
    if @credential.valid? then
      user = User.auth @credential
      if user.present?
        user_session.current_user = user
        redirect_to admin_root_path, notice: "Welcome <b>#{user.name}</b>!"
      else
        render_invalid_login
      end
    else
      render_invalid_login
    end
  end

  def logout
    user_session.destroy
    redirect_to admin_login_path, notice: "See you later!"
  end

private

  def credential_params
    params.require(:admin_credential).permit(:login, :password)
  end

  def render_invalid_login
    flash.now[:alert] = "Invalid login!"
    render :form
  end

  def user_session
    @user_session ||= UserSession.new(session)
  end
end
