class UserMailer < ApplicationMailer

  default :from => 'notifications@karrierbay.com'

  def welcome_email(user)
    p 'Mail Service'
    @user = user
    @url  = 'http://www.karrierbay/login'
    mail(:to => @user.id, :subject => 'Welcome to KarrierBay.com')
  end

end
