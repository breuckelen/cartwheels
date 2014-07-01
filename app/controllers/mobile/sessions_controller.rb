class Mobile::SessionsController < Devise::SessionsController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    skip_before_filter :authenticate_basic_http,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    skip_before_filter :authenticate_user_from_token, only: [:create]
    before_filter :authenticate_user_from_token, only: [:destroy]

    respond_to :json

    def create
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        auth_token   = current_user && current_user.authentication_token
        auth_token ||= current_owner && current_owner.authentication_token

        render :status => 200,
            :json => { :success => true,
                :info => "Logged in",
                :data => { :auth_token => auth_token } }
    end

    def destroy
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        if current_user
            current_user.update_column(:authentication_token, nil)
        else
            current_owner.update_column(:authentication_token, nil)
        end

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
end
