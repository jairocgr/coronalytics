class UserActivationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_activation_mailer.activate.subject
  #
  def activate(user)
    @user = user
    @activation_url = activation_url({
      id: @user.id,
      token: @user.activation_token
    })
    mail to: user.email,
      subject: t('user_activation_mailer.activate.subject')
  end
end
