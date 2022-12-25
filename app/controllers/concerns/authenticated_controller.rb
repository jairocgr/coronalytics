module AuthenticatedController
  extend ActiveSupport::Concern

  included do
    delegate :current_user, :user_signed_in?, to: :user_session
    helper_method :current_user, :user_signed_in?

    before_action :require_authentication
  end

  def user_session
    @user_session ||= UserSession.new(session)
  end

  def require_authentication
    unless user_signed_in? and current_user.allowed_to_access?
      redirect_to admin_login_path, alert: "Login required!"
    end
  end
end
