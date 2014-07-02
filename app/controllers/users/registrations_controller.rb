class Users::RegistrationsController < Devise::RegistrationsController
    def create
        build_resource(sign_up_params)

        if resource.save
            sign_in_and_redirect(resource)
        else
            failure
        end
    end

    def sign_in_and_redirect(resource)
        sign_in resource

        respond_to do |format|
            format.html { redirect_to home_path,
                notice: "Registered successfully"}
            format.js { render status: :ok,
                location: home_path,
                :json => { :success => true }}
        end
    end

    def failure
        respond_to do |format|
            format.html { render :new,
                notice: "Registration was unsuccessful"}
            format.js { render status: :unprocessable_entity,
                :json => { :errors => resource.errors, :success => false }}
        end
    end

    def sign_up_params
        params.require(:user).permit(:name, :email, :zip_code, :password,
            :password_confirmation, :provider, :uid)
    end

    private :sign_up_params
end
