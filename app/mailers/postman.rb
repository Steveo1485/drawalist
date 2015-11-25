require "mandrill"

class Postman < ActionMailer::Base

  default(
    from: "no-reply@drawalist.com"
  )

end