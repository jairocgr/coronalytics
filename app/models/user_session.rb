
class UserSession
  include ActiveModel::API

  def initialize(session)
    @session = session
  end

  def current_user=(user)
    @user = user
    @session[:user_id] = user.id
  end

  def current_user
    @user ||= User.find(@session[:user_id])
  end

  def user_signed_in?
    @session[:user_id].present?
  end

  def destroy
    @session[:user_id] = nil
  end
end
