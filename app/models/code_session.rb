
class CodeSession
  include ActiveModel::API

  def initialize(session)
    @session = session
  end

  def current_code=(code)
    @code = code
    @session[:code_id] = code.id
  end

  def current_code
    @code ||= AccessCode.find(@session[:code_id])
  end

  def user_with_code?
    @session[:code_id].present?
  end

  def destroy
    @session[:code_id] = nil
  end
  
  def count_access
    current_code.count_access()
  end
end
