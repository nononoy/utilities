class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login, :set_mailer_host

  private
    def not_authenticated
      redirect_to login_path, alert: "Вы находитесь на странице входа в сервис голосования. Если Вы здесь первый раз и хотите проголосовать, нужно зарегистрироваться."
    end

    def set_mailer_host
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end
end
