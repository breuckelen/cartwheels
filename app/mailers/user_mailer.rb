class UserMailer < ActionMailer::Base
    default from: "cartwheels.us@gmail.com"

    def welcome_email(user)
        @user = user
        @url = "http://cartwheels.us/login"
        mail(to: @user.email, subject: "Welcome to Cartwheels")
    end
end
