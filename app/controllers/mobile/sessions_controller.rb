class Mobile::SessionsController < Devise::SessionsController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    skip_before_filter :authenticate_basic_http,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_filter :authenticate_user_from_token!, only: [:destroy]

    respond_to :json

    def create
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render :status => 200,
            :json => { :success => true,
                :info => "Logged in",
                :data => { :auth_token => current_user.authentication_token } }
    end

    def destroy
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        current_user.update_column(:authentication_token, nil)
        render :status => 200,
            :json => { :success => true,
                :info => "Logged out",
                :data => {} }
    end

    def failure
        render :status => 401,
            :json => { :success => false,
                :info => "Login Failed",
                :data => {} }
    end

    private

    def authenticate_user_from_token!
        user_email = params[:user_email].presence
        user       = user_email && User.find_by_email(user_email)

        # Notice how we use Devise.secure_compare to compare the token
        # in the database with the token given in the params, mitigating
        # timing attacks.
        if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
            sign_in user, store: false
        end
    end
end
