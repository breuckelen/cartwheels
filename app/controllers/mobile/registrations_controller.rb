class Mobile::RegistrationsController < Devise::RegistrationsController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }
    skip_before_filter :authenticate_basic_http,
        :if => Proc.new { |c| c.request.format == 'application/json' }

    respond_to :json

    def create
        begin
            build_resource(user_sign_up_params)

            if resource.save
                sign_in resource

                render :status => 200,
                    :json => { :success => true,
                        :info => "Registered",
                        :data => { :user => resource,
                            :auth_token => current_user.authentication_token }}
            else
                render :status => :unprocessable_entity,
                    :json => { :success => false, :errors => resource.errors}
            end
        rescue
            build_resource(owner_sign_up_params)

            if resource.save
                sign_in resource

                render :status => 200,
                    :json => { :success => true,
                        :info => "Registered",
                        :data => { :user => resource,
                            :auth_token => current_owner.authentication_token }}
            else
                render :status => :unprocessable_entity,
                    :json => { :success => false, :errors => resource.errors }
            end
        end
    end

    def user_sign_up_params
        params.require(:user).permit(:name, :email, :zip_code, :password,
            :password_confirmation, :provider, :uid)
    end

    def owner_sign_up_params
        params.require(:owner).permit(:name, :email, :password,
            :password_confirmation)
    end

    private :user_sign_up_params
    private :owner_sign_up_params
end
