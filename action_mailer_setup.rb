ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.mandrillapp.com',
  port: '587', # ports 587 and 2525 are also supported with STARTTLS
  user_name: 'damir.svrtan@gmail.com',
  password: 'pZxI_QHcJBdJ3sTUBB2vWg', # SMTP password is any valid API key
  authentication: 'plain', # Mandrill supports 'plain' or 'login'
  # domain: 'shipitlab.infinum.co', # your domain to identify your server when connecting
}
