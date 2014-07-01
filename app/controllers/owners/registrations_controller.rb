class Owners::RegistrationsController < Devise::RegistrationsController
    def sign_up_params
        params.require(:owner).permit(:name, :email, :password, :password_confirmation)
    end

    private :sign_up_params
end
