
class UserActivationController < ApplicationController

  def activation_form
    id = params[:id]
    token = params[:token]
    @user = User.pending_activation.find_by(id: id, activation_token: token)
    user_not_found unless @user.present?
  end

  def activate
    id = params[:id]
    token = params[:token]
    @user = User.pending_activation.find_by(id: id, activation_token: token)

    user_not_found unless @user.present?

    if @user.update(password_params)
      @user.activate!
      redirect_to admin_users_path, notice: "User #{@user.name} activated!"
    else
      flash.now[:alert] = t('validation_error')
      render :activation_form
    end
  end

private

  def user_not_found
    # This would be unusual situation
    id = params[:id]
    token = params[:token]
    logger.warn "Someone tried a invalid token #{token} for id #{id}"
    redirect_to '/'
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
