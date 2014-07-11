class OwnerMailer < ActionMailer::Base
    default from: "cartwheels.us@gmail.com"

    def welcome_email(owner)
        @owner = owner
        @url = "http://cartwheels.us/login"
        mail(to: @owner.email, subject: "Welcome to Cartwheels for Owners")
    end
end
