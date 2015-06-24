class UserMailer < ActionMailer::Base
  default from: "butterchicken@mailinator.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Goodbye from My Awesome Site')
  end
end
