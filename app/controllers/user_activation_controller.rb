
class UserActivationController < ApplicationController

  def activation_form

    id = params[:id]
    token = params[:token]

    @user = User.pending_activation.find_by(id: id, activation_token: token)

    unless @user.present? then
      # This would be unusual situation
      logger.warn "Someone tried a invalid token #{token} for id #{id}"
      redirect_to '/'
    end
  end

end
