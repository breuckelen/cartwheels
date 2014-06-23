class Users::RegistrationsController < Devise::RegistrationsController
    before_filter :authenticate_basic_http

    def sign_up_params
        params.require(:user).permit(:name, :email, :zip_code, :password,
            :password_confirmation, :provider, :uid)
    end

    private :sign_up_params
end
