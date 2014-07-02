class Owners::SessionsController < Devise::SessionsController
    def create
        resource = Owner.find_by_email(sign_in_params[:email])

        if resource && resource.valid_password?(sign_in_params[:password])
            sign_in_and_redirect(resource)
        else
            failure
        end
    end

    def sign_in_and_redirect(resource)
        sign_in resource

        respond_to do |format|
            format.html { redirect_to home_path,
                notice: "Logged in successfully"}
            format.js { render status: :ok,
                location: home_path,
                :json => { :success => true }}
        end
    end

    def failure
        respond_to do |format|
            format.html { render :new,
                notice: "Login failed"}
            format.js { render status: :unprocessable_entity,
                :json => { :errors => ["Email and password combination is invalid"], :success => false }}
        end
    end
end
