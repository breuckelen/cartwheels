class UsersController < ApplicationController
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

        unless @user == current_user
            return redirect_to :home, :notice => "Access denied."
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

    # action for editing subscriptions
    def edit_subscriptions
        # redirect unless correct user
        # html:
        # allow for deletion of subscriptions
    end

    respond_to :json

    def data
        @users = User.where(data_params)
            .limit(search_params["limit"].to_i)
            .offset(search_params["offset"].to_i)

        render :status => 200,
            :json => {
                :success => true,
                :data => @users
            }
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
