class Users::SessionsController < Devise::SessionsController
    def create
        resource = User.find_by_email(sign_in_params[:email])

        if resource && resource.valid_password?(sign_in_params[:password])
            sign_in_and_redirect(resource)
        else
            failure
        end
    end

    def sign_in_and_redirect(resource)
        sign_in resource

        respond_to do |format|
            flash[:notice] = "Logged in successfully"
            format.html { redirect_to home_path }
            format.json { render status: :ok,
                location: last_path(resource),
                json: { success: true }}
            format.js { render "shared/concerns/login",
                locals: { errors: nil, user: resource, redirect_path: last_path(resource)}}
        end
    end

    def failure
        respond_to do |format|
            errors = {user: "Email and password combination is invalid"}
            format.html { render :new,
                notice: "Login failed"}
            format.json { render status: :unprocessable_entity,
                json: { errors: errors, success: false }}
            format.js { render "shared/concerns/login",
                locals: { errors: errors }}
        end
    end
end
