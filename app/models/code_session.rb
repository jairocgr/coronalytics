
class CodeSession
  include ActiveModel::API

  def initialize(session)
    @session = session
  end

  def current_code=(code)
    @code = code
    @session[:code] = code
  end

  def current_code
    @code ||= @session[:code]
  end

  def user_with_code?
    @session[:code].present?
  end

  def destroy
    @session[:code] = nil
  end
end
