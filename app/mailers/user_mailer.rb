class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(to: user.email, subject: "Восстановление пароля на портале СистемаРосДом", content_type: "text/html")
  end

  def activation_needed_email(user)
    @user = user
    @url  = "http://#{ActionMailer::Base.default_url_options[:host]}/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: "Активация учетной записи на портале СистемаРосДом", content_type: "text/html")
  end

  def activation_success_email(user)
    @user = user
    @url  = "http://#{ActionMailer::Base.default_url_options[:host]}/login"
    @profile_url = "http://#{ActionMailer::Base.default_url_options[:host]}/profile"
    mail(to: user.email, subject: "Ваш аккаунт на портале СистемаРосДом активирован", content_type: "text/html")
  end
end
