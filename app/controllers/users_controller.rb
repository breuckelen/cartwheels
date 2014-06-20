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

    def data
    end
end
