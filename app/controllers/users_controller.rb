class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)

        if @user.save
            redirect_to root_url
        else
            render 'new'
        end
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation,
                                     :username, :zip_code)
    end
end
