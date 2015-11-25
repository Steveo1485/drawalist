def set_up_mailer
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.deliveries = []
end