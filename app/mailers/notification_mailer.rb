class NotificationMailer < ActionMailer::Base
  default from: "support@washingtongraphic.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to our online annotation tool')
  end

  def notification_email(user,activities)
    @user = user
    @activities = activities
    mail(to: @user.email, subject: 'todays notifications')
  end

end
