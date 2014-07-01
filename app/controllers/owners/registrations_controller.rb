class Owners::RegistrationsController < Devise::RegistrationsController
    def sign_up_params
        params.require(:owner).permit(:name, :email, :password, :password_confirmation, :owner_secret)
    end

    private :sign_up_params
end
