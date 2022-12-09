module CodeProtectedController
  extend ActiveSupport::Concern

  included do
    delegate :current_code, :user_with_code?, to: :code_session
    helper_method :current_code, :user_with_code?

    before_action :require_code
  end

  def code_session
    @code_session ||= CodeSession.new(session)
  end

  def require_code
    unless user_with_code?
      redirect_to code_login_path, alert: "Access code required!"
    end
  end
end
