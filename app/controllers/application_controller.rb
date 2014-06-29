class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :authenticate_basic_http

    # For mobile actions
    skip_before_filter :authenticate_basic_http,
        only: [:create, :update, :destroy, :data, :search],
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_filter :authenticate_user_from_token,
        only: [:create, :update, :destroy, :data, :search],
        :if => Proc.new { |c| c.request.format == 'application/json' }
    before_filter :authenticate_user!, only: [:create, :update, :destroy]

    def authenticate_basic_http
        if Rails.env.production?
            authenticate_or_request_with_http_basic do |username, password|
                username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
            end
        end
    end

    def authenticate_user_from_token
        user_email = params[:email].presence
        user       = user_email && User.find_by_email(user_email)

        # Notice how we use Devise.secure_compare to compare the token
        # in the database with the token given in the params, mitigating
        # timing attacks.
        if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
            sign_in user, store: false
        end
    end

    private :authenticate_basic_http
    private :authenticate_user_from_token
end
