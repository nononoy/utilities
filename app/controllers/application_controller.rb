class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login

  before_action :set_mailer_host



  private
    def not_authenticated
      redirect_to login_path, alert: "Необходимо войти или зарегистрироваться"
    end

    def set_mailer_host
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end
end
