
class CodeLoginController < ApplicationController

  def form
  end

  def login
    code = AccessCode.actives.find_by code: params[:access_code]
    if code.blank? then
      flash.now[:alert] = "Invalid access code '<b>#{params[:access_code]}</b>'"
      render :form
    else
      code_session.current_code = code
      redirect_to root_path, notice: "Welcome <b>#{code.name}</b> (code=#{code.code})!"
    end
  end

private

  def code_session
    @code_session ||= CodeSession.new(session)
  end

end
