class ApplicationMailer < ActionMailer::Base
  default from: "noreply@sistemarosdom.ru", content_type: "text/html"
  layout 'mailer'
end
