class Owners::RegistrationsController < Devise::RegistrationsController
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
        OwnerMailer.welcome_email(resource).deliver

        respond_to do |format|
            format.html { redirect_to home_path,
                notice: "Registered successfully"}
            format.json { render status: :ok,
                location: home_path,
                :json => { :success => true }}
            format.js { render "shared/concerns/form_default",
                locals: { errors: nil, user: resource, redirect_path: home_path}}
        end
    end

    def failure
        respond_to do |format|
            format.html { render :new,
                notice: "Registration was unsuccessful"}
            format.json { render status: :unprocessable_entity,
                :json => { :errors => resource.errors, :success => false }}
            format.js { render "shared/concerns/form_default",
                locals: { errors: resource.errors }}
        end
    end

    def sign_up_params
        params.require(:owner).permit(:name, :email, :password, :password_confirmation)
    end

    private :sign_up_params
end
