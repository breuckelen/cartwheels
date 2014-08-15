class UsersController < ApplicationController
    include Fetchable

    skip_before_filter :authenticate_user!
    skip_before_filter :authenticate_owner!
    skip_before_action :set_instance

    def show
        if params.has_key? :id
            begin
                @user = User.find(params[:id])
            rescue
                return redirect_to :home, :notice => "This user does not exist."
            end
        else
            @user = current_user

            unless @user != nil
                return redirect_to :home, :notice => "You are not logged in."
            end
        end
    end

    def edit
        # redirect unless correct user
    end

    def update
        # redirect unless correct user
    end

    def destroy
        # redirect unless correct user, admin, or manager
    end

    def data_params
        params.require(:user).permit(:id, :authentication_token, :email, :name, :zip_code)
    end

    def search_params
        ps = params.permit(:offset, :limit, :tq, :lq)
        defaults = {"offset" => 0, "limit" => 20}
        defaults.merge(ps)
    end

    private :data_params
    private :search_params
end
