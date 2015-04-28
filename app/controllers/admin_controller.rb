require "application_responder"

class AdminController < InheritedResources::Base
  http_basic_authenticate_with name: "utilities", password: "12345"

  self.responder = ApplicationResponder
  respond_to :html
  skip_before_action :require_login, :set_mailer_host
  layout 'admin'

  # protect_from_forgery with: :exception



  # before_action :require_login
  # before_action :authenticate_admin

end
